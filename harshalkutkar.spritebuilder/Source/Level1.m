#import "Level1.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Fly.h"
#import "GamePlay.h"
#include "Bird.h"
#import "Egg.h"

//number of items you can pick from in the left menu
const int NUMBER_ITEMS = 1;

@implementation Level1{
    CCPhysicsNode *_physicsNode;
    CCButton *_button0;
    CCSprite *_item0;
    Boolean _dragMode;
    NSInteger _dragIndex;
    CCNode *_levelNode;
    CCLabelTTF *_score;
    int score;
    CCNode *_eggNode;
    NSArray *eggStartingLocations;
    NSMutableArray *allEggs;
    int aliveCount;
    CCLabelTTF *_lblitem0count;
    float gameTime;
    int lives[NUMBER_ITEMS];
}



// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    
    _physicsNode.collisionDelegate = self;
    self.userInteractionEnabled = YES;
    
    //initialize the lives
    lives[0] = 1;
    [_lblitem0count setString: [NSString stringWithFormat:@"%d",lives[0]] ];
    
    //Setup
    _dragMode = false;
    _dragIndex = 0;
    
    [self initEggLocations];
    
    //score
    score = 0;
    
       [self generateEnemies];
    [self randomTimeScheduler];
    
    
}

- (void) initEggLocations
{
    eggStartingLocations = [NSArray arrayWithObjects:
                              [NSValue valueWithCGPoint:CGPointMake(475, 193)],
                              [NSValue valueWithCGPoint:CGPointMake(441, 168)],
                              [NSValue valueWithCGPoint:CGPointMake(484, 136)],
                              [NSValue valueWithCGPoint:CGPointMake(507, 220)],
                            nil
                            ];
    
    //Keeping track of live eggs
    
    allEggs = [NSMutableArray new];
    
    
    for (int i=0; i<eggStartingLocations.count;i++)
    {
        NSValue *val = [eggStartingLocations objectAtIndex:i];
        CGPoint p = [val CGPointValue];
        //Create an Egg
        Egg* egg = (Egg*)[CCBReader load:@"Egg"];
        egg.position = p;
        egg.scaleX = 0.5f;
        egg.scaleY = 0.5f;
        [_eggNode addChild:egg];
        [allEggs addObject:egg];
        aliveCount++;
    }
    
    //increment count
    [self incrementFirstLife];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bird:(Bird *)nodeA egg:(Egg *)nodeB {
    NSLog(@"Collision Occurred between BirdZero & Egg");
    [self birdRemoved:nodeA];
    [self eggRemoved:nodeB];
    
    for (Egg *e in allEggs)
    {
        if (e.isAlive == false)
        {
            aliveCount--;
        }
    }
    
    if (aliveCount <= 0) { [self showWinLoseDialog:@"You lose!"]; }
  
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bird:(CCNode *)nodeA fly:(CCNode *)nodeB {
    NSLog(@"Collision Occurred between Bird & Fly");
    [self birdRemoved:nodeA];
    [self flyRemoved:nodeB];
    score += 100;
    [_score setString:[NSString stringWithFormat:@"%d",score]];
  
    
}

- (void) showWinLoseDialog : (NSString *) string {
    [[CCDirector sharedDirector] pause];
    CCNode* diag = [CCBReader load:@"WinLoseDialog"];
    [diag setName:string];
    [self addChild:diag];
    
}

- (void)eggRemoved:(Egg *)egg {
    [egg crackEgg];
    
}

- (void)birdRemoved:(CCNode *)bird {
    [bird removeFromParent];
}

- (void)flyRemoved:(CCNode *)fly {
    [fly removeFromParent];
}

- (void)button0 {
    
    if (lives[0] > 0)
    {
    CCLOG(@"Drag mode on");
    _dragIndex = 0; //since theres only one button
    _dragMode = true;
    }
   
    
    
}

//Hacky touch and place.
- (void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event
{
   if (_dragMode)
   {
       if (_dragIndex == 0)
       {
       // we want to know the location of our touch in this scene
       CGPoint touchLocation = [touch locationInNode:self];
       // create a 'hero' sprite
       CCNode* fly = [CCBReader load:@"Fly"];
    
           fly.scaleX = 0.3;
           fly.scaleY = 0.3;
       [_physicsNode addChild:fly];
       // place the sprite at the touch location
       fly.position = touchLocation;
       
        //decrement the count
        lives[_dragIndex]--;
        [self updateLabels];
        [self disableOrEnableButtons];
       }
       
       
       //disable dragmode
       _dragMode = false;
   }
}

-(void)update:(CCTime)delta
{
    gameTime += (delta);
    
   
}

- (void) generateEnemies
{
    
    int i = arc4random() % 6;
    
    //Random Y generation
    float low_bound = 70;
    float high_bound = 280;
    int rndY = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    
    
    //Create a Bird
    Bird* enemy = (Bird*)[CCBReader load:@"BirdZero"];
    
    float randomNum = ((float)rand() / RAND_MAX) * 3;
    //Set Params
    [enemy setSpeed:randomNum];
    enemy.position = CGPointMake(100, rndY);
    enemy.scaleX = 0.3;
    enemy.scaleY = 0.3;
    [_physicsNode addChild:enemy];
 
    
}

- (void) randomTimeScheduler {
    int time = arc4random()%5;
    int nextTimeOfCall = 3+time;
    NSLog(@"it will be called after:%d",nextTimeOfCall);
    [self performSelector:@selector(randomTimeScheduler) withObject:self afterDelay:nextTimeOfCall];
    for (int i=0;i<time;i++)
    {
        float randomNum = ((float)rand() / RAND_MAX) * 3;     // now in seconds
        [self scheduleOnce:@selector(generateEnemies) delay:randomNum];
        [self generateEnemies];
    }
    
}


- (void) incrementFirstLife
{
    lives[0]++;
    [_lblitem0count setString: [NSString stringWithFormat:@"%d",lives[0]] ];
    [self disableOrEnableButtons];
    [self scheduleOnce:@selector(incrementFirstLife) delay:5.0f];
   
   
}

-(void) updateLabels
{
      [_lblitem0count setString: [NSString stringWithFormat:@"%d",lives[0]] ];
}
    

- (void) disableOrEnableButtons
{
    //also disable buttons
    if (lives[0] <= 0)
    {
        [_button0 setEnabled:false];
    }
    else
    {
        [_button0 setEnabled:true];
    }
}



@end
