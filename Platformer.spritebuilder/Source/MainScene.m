#import "MainScene.h"
#import <CoreMotion/CoreMotion.h>
#import "Pipe.h"
#import "Ball.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation MainScene
{
    Ball *_ball;
    CCNode *_physicsNode;
    CCSprite *_rotatingBlock;
    CCNode *_contentNode;
    
}

- (id)init {
    if (self = [super init])
    {
    }
    
    return self;
}


- (void)didLoadFromCCB {
    
    
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    [_physicsNode addChild:_ball];
    
   
    
    
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_ball worldBoundary:self.boundingBox];
    [self runAction:follow];
    
    
    self.userInteractionEnabled = YES;
    
    //get the size of screen
     CGSize s = [CCDirector sharedDirector].viewSize;
    
    
    // set the rotation
    CCActionRotateBy *rot = [CCActionRotateBy actionWithDuration:1 angle:360];
    
    
    [_rotatingBlock runAction:[CCActionRepeatForever actionWithAction:rot]];
    
 
    
}


- (void) update:(CCTime)delta
{
    //get the size of screen
    CGSize s = [CCDirector sharedDirector].viewSize;
    
       
    [self boundsCheck];
   
}

-(void) boundsCheck
{
    
    
    if (_ball.position.y < 33)
    {
        CCScene *scene =  [CCBReader loadAsScene:@"LoseDialog"];
        [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
    }
    
    
    
}

-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair pipe:(CCNode *)nodeA ball:(CCNode *)nodeB {
    NSLog(@"Collision ");
}



@end
