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
    CCLabelTTF *_score;
    int currentLevel;
    
}

- (id)init {
    if (self = [super init])
    {
            //init level
        currentLevel = 2;
       
    }
    
    return self;
}


- (void)didLoadFromCCB {
    
   
    
    //set keys
    [[GameManager sharedGameManager] setKeys:0];
    
    //update
    [self updateHUD];
    
    //Make sure we get the callback after a collision.
    _physicsNode.collisionDelegate = self;
    
    
    //Load the initial ball at the top
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    
    //Add it to the physics node.
    [_physicsNode addChild:_ball];
    
    
    //Set the current level to one.
    [[GameManager sharedGameManager] setCurrentLevel:currentLevel];
    
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
    else
    {
        //Show the Lose Dialog
        CCScene *scene =  [CCBReader loadAsScene:@"LoseDialog"];
        [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
        
    }

    [self updateHUD];
    return YES;
}

//Birthday Cake Bounce
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA bCake:(CCNode *)nodeB
{
    NSLog(@"Ball collided with bcake");
    [nodeA.physicsBody applyImpulse:ccp(0, 3500.f)];
    return YES;
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA key:(Key *)nodeB
{
    NSLog(@"Ball and Key Collided");
    //Add a Key (From the Singleton)
    [[GameManager sharedGameManager] addKey];
    //Remove the key
    [nodeB removeFromParentAndCleanup:true];
    [self updateHUD];
    return YES;
}


/*
 * Updates the HUD. Has to be called manually.
 *
 */
- (void) updateHUD
{
    int requiredKeys = [[GameManager sharedGameManager] getRequiredKeysForLevel:currentLevel];
    int currentKeys = [[GameManager sharedGameManager] getKeys];
    NSString *scoreString =  [NSString stringWithFormat:@"%d/%d",currentKeys,requiredKeys];
    [_score setString:scoreString];
}



@end
