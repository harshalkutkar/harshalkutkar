#import "MainScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Fly.h"
#import "GamePlay.h"
#include "Bird.h"
#import "Egg.h"


@implementation MainScene{
    CCPhysicsNode *_physicsNode;
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
}



// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    
    _physicsNode.collisionDelegate = self;
    self.userInteractionEnabled = YES;
    
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
    CCLOG(@"Drag mode on");
    _dragIndex = 1;
    _dragMode = true;
}

//Hacky touch and place.
- (void)touchBegan:(CCTouch *)touch withEvent:(UIEvent *)event
{
   if (_dragMode)
   {
       if (_dragIndex == 1)
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
           
         
       }
       
       
       //disable dragmode
       _dragMode = false;
   }
}

-(void)update:(CCTime)delta
{
    
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








@end
