#import "Level2.h"
#import <CoreMotion/CoreMotion.h>
#import "Pipe.h"
#import "Ball.h"
#import "Key.h"
#import "GameManager.h"
#import "CCPhysics+ObjectiveChipmunk.h"


@implementation Level2
{
    Ball *_ball;
    CCPhysicsNode *_physicsNode;
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
    
    //Make sure we get the callback after a collision.
    _physicsNode.collisionDelegate = self;
    
    
    //Load the initial ball at the top
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    
    //Add it to the physics node.
    [_physicsNode addChild:_ball];
    
    
    //Set the Number of Keys collected to zero:
    [[GameManager sharedGameManager] setKeys:0];
    
    //Set the current level to one.
    [[GameManager sharedGameManager] setCurrentLevel:2];
    
    //Set the camera to follow the ball (might need it later)
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_ball worldBoundary:self.boundingBox];
    [self runAction:follow];
    
    
    //Make sure user interaction is enabled.
    self.userInteractionEnabled = YES;
    
    
    // if you have a rotating block variable
    CCActionRotateBy *rot = [CCActionRotateBy actionWithDuration:1 angle:360];
    [_rotatingBlock runAction:[CCActionRepeatForever actionWithAction:rot]];
    
    
    
}


- (void) update:(CCTime)delta
{
    
}


/*
 *  Physics Collision Handlers
 *  Collision between a ball and a pipe.
 */

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA pipe:(CCNode *)nodeB
{
    NSLog(@"Ball and Pipe Collided");
    
    //Check if the required number of keys was set.
    BOOL hasKeys = [[GameManager sharedGameManager] checkIfPlayerHasRequiredKeysForLevel];
    
    if (hasKeys)
    {
        //Enable the Pipe (change the hue // todo)
        
        
        //Show the Win Dialog
        CCScene *scene =  [CCBReader loadAsScene:@"WinDialog"];
        [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
        
    }
    
    return YES;
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA key:(Key *)nodeB
{
    NSLog(@"Ball and Key Collided");
    //Add a Key (From the Singleton)
    [[GameManager sharedGameManager] addKey];
    
    //Remove the key
    [nodeB removeFromParentAndCleanup:true];
    
    return YES;
}




@end
