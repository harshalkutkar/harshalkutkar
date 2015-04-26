#import "Level1.h"
#import <CoreMotion/CoreMotion.h>
#import "Pipe.h"
#import "Ball.h"
#import "Key.h"
#import "GameManager.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "UpAndDownBlock.h"

int const POINTS_GINGERBREAD = 75;
int const POINTS_COCUPCAKE = 150;

@implementation Level1
{
    Ball *_ball;
    CCPhysicsNode *_physicsNode;
    CCNode *_ballNode;
    CCNode *_contentNode;
    CCLabelTTF *_score;
    CCLabelTTF *_points;
    CCLabelTTF *_message;
}

- (id)init {
    if (self = [super init])
    {
    }
    
    return self;
}


- (void)didLoadFromCCB {
    
    
    
    //set keys
    [[GameManager sharedGameManager] setKeys:0];
    
    //set points
    [[GameManager sharedGameManager] setPoints:0];
    
    //update [has to come after set!]
    [self updateHUD];
    
   
    //Make sure we get the callback after a collision.
    _physicsNode.collisionDelegate = self;
    
    
    //Load the initial ball at the top
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    
    //Add it to the physics node.
    [_physicsNode addChild:_ball];

    
    //Set the camera to follow the ball (might need it later)
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_ball worldBoundary:self.boundingBox];
    [self runAction:follow];
    
    
    //Make sure user interaction is enabled.
    self.userInteractionEnabled = YES;
    

    
 
    
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


- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(Ball *)nodeA portal:(Portal *)nodeB
{
    CGPoint destination = [[GameManager sharedGameManager] getLocationOfPortal:[nodeB getConnectedPortalId]];
    
    [nodeA setPositionType:CCPositionTypePoints];
    int angle = [[GameManager sharedGameManager] getAngleOfPortal:[nodeB getConnectedPortalId]];
    
    
    NSLog(@"Angle: %d ",angle);
     if (angle == -270 )
     {
         destination.y = destination.y - 50;
     }
    
    if (angle == 0)
    {
        destination.x = destination.x + 50;
        [nodeA.physicsBody applyImpulse:(ccp(400.0f,0))];
        
    }
    
    [nodeA setPositionInPoints:destination];
    
   
    NSLog(@"Destination: %f ,%f",destination.x+50, destination.y);
   
    
    return YES;
    
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA key:(Key *)nodeB
{
    NSLog(@"Ball and Key Collided");
    //Add a Key (From the Singleton)
    [[GameManager sharedGameManager] addKey];
    
    //Remove the key
    [nodeB removeFromParentAndCleanup:true];
    
    //if required keys display message
    
    BOOL hasKeys = [[GameManager sharedGameManager] checkIfPlayerHasRequiredKeysForLevel];
    if (hasKeys)
    {
        [_message setString:@"Proceed to pipe!"];
    }
    
    
     [self updateHUD];
    
    return YES;
}

/*
 * Updates the HUD. Has to be called manually.
 *
 */
- (void) updateHUD
{
    int currentLevel =[[GameManager sharedGameManager] getCurrentLevel];
    int requiredKeys = [[GameManager sharedGameManager] getRequiredKeysForLevel:currentLevel];
    int currentKeys = [[GameManager sharedGameManager] getKeys];
    NSString *scoreString =  [NSString stringWithFormat:@"%d/%d",currentKeys,requiredKeys];
    [_score setString:scoreString];
    //refresh points as well!
    int points = [[GameManager sharedGameManager] getPoints];
    [_points setString:[NSString stringWithFormat:@"%d",points]];
}


//Birthday Cake Bounce
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA bCake:(CCNode *)nodeB
{
    NSLog(@"Ball collided with bcake");
    [nodeA.physicsBody applyImpulse:ccp(0, 1000.f)];
    return YES;
}




//Gingerbread Cookie
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA gingerbread:(CCNode *)nodeB
{
    NSLog(@"Ball collided with Gingerbread");
    [nodeB removeFromParentAndCleanup:true];
    int oldPoints = [[GameManager sharedGameManager] getPoints];
    int newPoints = oldPoints + POINTS_GINGERBREAD;
    [[GameManager sharedGameManager] setPoints:newPoints];
    [self updateHUD];
    return YES;
}




//Chocolate Orange Cup Cake Bounce
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA cocupcake:(CCNode *)nodeB
{
    NSLog(@"Ball collided with chocolate orange cupcake");
    //Remove the key
    [nodeB removeFromParentAndCleanup:true];
    //Make the donut grow
    float current_scale = nodeA.scale;
    [nodeA setScale:current_scale*1.3];
    
    [_message setString:@"You're getting fat! Work out for a while."];
    [self performSelector:@selector(makeNormalSize:) withObject:nil afterDelay:7.0f];
    _ball.physicsBody.density = 6.00f;
    
    //update the points
    int oldPoints = [[GameManager sharedGameManager] getPoints];
    int newPoints = oldPoints + POINTS_COCUPCAKE;
    [[GameManager sharedGameManager] setPoints:newPoints];
    
    [self updateHUD];
    return YES;
}
-(void) makeNormalSize:(CCTime)dt
{
    
    [_ball setScale:_ball.scale*0.7];
    _ball.physicsBody.density = 5.00f;
}



@end
