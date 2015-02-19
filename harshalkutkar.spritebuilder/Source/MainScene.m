#import "MainScene.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "Fly.h"

@implementation MainScene{
    CCPhysicsNode *_physicsNode;
    CCSprite *_item0;
    Boolean _dragMode;
    NSInteger _dragIndex;
    NSInteger rows[3];
    
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
    rows[0] = 260;
    rows[1] = 179;
    rows[2] = 113;
    rows[3] = 42;
    
    [self randomTimeScheduler];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair boar:(CCNode *)nodeA egg:(CCNode *)nodeB {
    NSLog(@"Collision Occurred between Boar & Egg");
    [self eggRemoved:nodeB];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair boar:(CCNode *)nodeA fly:(CCNode *)nodeB {
    NSLog(@"Collision Occurred between Boar & Fly");
    [self boarRemoved:nodeA];
}

- (void)eggRemoved:(CCNode *)egg {
    [egg removeFromParent];
}

- (void)boarRemoved:(CCNode *)boar {
    [boar removeFromParent];
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
       fly.scaleX = 0.5;
       fly.scaleY = 0.5;

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

    int i = arc4random() % 3;
    CCNode* enemy = [CCBReader load:@"Boar"];
   
    
    enemy.position = CGPointMake(0, rows[i]);
    enemy.scaleX = 0.4;
    enemy.scaleY = 0.4;
    [_physicsNode addChild:enemy];
 
    
}

- (void) randomTimeScheduler {
    int time = arc4random()%5;
    int nextTimeOfCall = 3+time;
    NSLog(@"it will be called after:%d",nextTimeOfCall);
    [self performSelector:@selector(randomTimeScheduler) withObject:self afterDelay:nextTimeOfCall];
    [self generateEnemies];
    
}



@end
