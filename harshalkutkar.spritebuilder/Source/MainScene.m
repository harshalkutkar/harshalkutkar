#import "MainScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Fly.h"
#import "GamePlay.h"


@implementation MainScene{
    CCPhysicsNode *_physicsNode;
    CCSprite *_item0;
    Boolean _dragMode;
    NSInteger _dragIndex;
    NSInteger rows[7];
    CCNode *_levelNode;
    CCLabelTTF *_score;
    int score;
    
}



// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    
    _physicsNode.collisionDelegate = self;
    self.userInteractionEnabled = YES;
    
    //Setup
    _dragMode = false;
    _dragIndex = 0;
    
    [self generateEnemies];
    
    //rows (y cord arrays)
    rows[0] = 286;
    rows[1] = 248;
    rows[2] = 210;
    rows[3] = 170;
    rows[4] = 127;
    rows[5] = 88;
    rows[6] = 70;
    
    //score
    score = 0;
    
    [self randomTimeScheduler];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair boar:(CCNode *)nodeA egg:(CCNode *)nodeB {
    NSLog(@"Collision Occurred between Boar & Egg");
    [self eggRemoved:nodeB];
    [self showWinLoseDialog:@"You lose!"];
  
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair boar:(CCNode *)nodeA fly:(CCNode *)nodeB {
    NSLog(@"Collision Occurred between Boar & Fly");
    [self boarRemoved:nodeA];
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

- (void)eggRemoved:(CCNode *)egg {
    [egg removeFromParent];
}

- (void)boarRemoved:(CCNode *)boar {
    [boar removeFromParent];
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
    
           fly.scaleX = 0.9;
           fly.scaleY = 0.9;
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
    CCNode* enemy = [CCBReader load:@"Boar"];
    enemy.position = CGPointMake(0, rows[i]);
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
    [self generateEnemies];
    }
    
}







@end
