#import "Level1.h"
#import <CoreMotion/CoreMotion.h>
#import "Pipe.h"
#import "Ball.h"
#import "Key.h"
#import "GameManager.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "UpAndDownBlock.h"
#import "Onboard.h"
#import "Mixpanel.h"

#define MIXPANEL_TOKEN @"69eb3e9dde2cc4e5324b00727134192e"

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
    CCNode *_onboardNode;
}

- (id)init {
    if (self = [super init])
    {
    }
    
    return self;
}


- (void)didLoadFromCCB {
    
  
    // Initialize the library with your
    // Mixpanel project token, MIXPANEL_TOKEN
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];

    
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
    
    
    
    //Make sure user interaction is enabled.
    self.userInteractionEnabled = YES;
    
    //If level 1 start onboarding
    int current = [[GameManager sharedGameManager] getCurrentLevel];
    if (current == 1)
    {
        //Load Onboarding #1
        Onboard *_onOne = (Onboard*) [CCBReader load:@"OnboardOne" owner:self];
        _onOne.position = ccp(0,0);
        [_onboardNode addChild:_onOne];
        [_ball setPaused:true];
        
      
    }
    else if (current == 2)
    {
        //Load Onboarding #3
        Onboard *_onOne = (Onboard*) [CCBReader load:@"OnboardThree" owner:self];
        _onOne.position = ccp(0,0);
        [_onboardNode addChild:_onOne];
        
        
    }
    else if (current == 3)
    {
        //Load Onboarding #4
        Onboard *_onOne = (Onboard*) [CCBReader load:@"OnboardFour" owner:self];
        _onOne.position = ccp(0,0);
        [_onboardNode addChild:_onOne];
    }
    else
    {
        
        //Load the initial ball at the top
      
        [_physicsNode addChild:_ball];
        
    }
    
    //Mixpanel Tracking
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    
    [mixpanel track:@"Level Started" properties:@{
                                                  @"Level": @([[GameManager sharedGameManager] getCurrentLevel]).stringValue,
                                                  @"Time":  [self getCurrentTime]
                                                  }];
    

    
 
    
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
     if (angle == 90 )
     {
         destination.y = destination.y - 50;
         
     }
    
    if (angle == 0)
    {
        destination.x = destination.x + 50;
       
        
    }
    //Particle Effect
    // load particle effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Eat"];
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = nodeB.position;
    // add the particle effect to the same node the seal is on
    [nodeB.parent addChild:explosion];
    
    
    //coming In effect
    // load particle effect
    CCParticleSystem *explosion2 = (CCParticleSystem *)[CCBReader load:@"Entry"];
    // make the particle effect clean itself up, once it is completed
    explosion2.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion2.position = destination;
    // add the particle effect to the same node the seal is on
    [nodeB.parent addChild:explosion2];
    
    
    [nodeA setPositionInPoints:destination];
    
   
    NSLog(@"Destination: %f ,%f",destination.x+50, destination.y);
   
    
    return YES;
    
}

- (BOOL)ccPhysicsCollisionPreSolve:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA key:(Key *)nodeB
{
    NSLog(@"Ball and Key Collided");
    //Play Sound
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"chime.mp3" loop:NO];

    
    //Add a Key (From the Singleton)
    [[GameManager sharedGameManager] addKey];
    
    //Particle Effect
    // load particle effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Eat"];
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = nodeB.position;
    // add the particle effect to the same node the seal is on
    [nodeB.parent addChild:explosion];
    
    
    //Remove the key
    [nodeB removeFromParentAndCleanup:true];
    
    //if required keys display message
    
    BOOL hasKeys = [[GameManager sharedGameManager] checkIfPlayerHasRequiredKeysForLevel];
    if (hasKeys)
    {
        [_message setString:@"Proceed to pipe!"];
    }
    
    //Mixpanel Tracking
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Key(Lolly) Collected" properties:@{
                                                                       @"Level": @([[GameManager sharedGameManager] getCurrentLevel]).stringValue,
                                                                       @"Time":  [self getCurrentTime],
                                                                       @"Score": @([[GameManager sharedGameManager] getPoints]).stringValue,
                                                                       @"Keys Collected":@([[GameManager sharedGameManager] getKeys]).stringValue
                                                                       }];

    
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
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"Boink.caf" loop:NO];
    return YES;
}




//Gingerbread Cookie
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair ball:(CCNode *)nodeA gingerbread:(CCNode *)nodeB
{
    NSLog(@"Ball collided with Gingerbread");
    [nodeB removeFromParentAndCleanup:true];
    int oldPoints = [[GameManager sharedGameManager] getPoints];
    int newPoints = oldPoints + POINTS_GINGERBREAD;
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"CashRegister.mp3" loop:NO];
    
    //track with mixpanel
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Gingerbread Collected" properties:@{
                                                  @"Level": @([[GameManager sharedGameManager] getCurrentLevel]).stringValue,
                                                  @"Time":  [self getCurrentTime],
                                                  @"Score": @([[GameManager sharedGameManager] getPoints]).stringValue
                                                  }];

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
    
    //Mixpanel Cupcake Tracking
    //track with mixpanel
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Chocolate Orange Cupcake Collected" properties:@{
                                                          @"Level": @([[GameManager sharedGameManager] getCurrentLevel]).stringValue,
                                                          @"Time":  [self getCurrentTime],
                                                          @"Score": @([[GameManager sharedGameManager] getPoints]).stringValue
                                                          }];
    
    [self updateHUD];
    return YES;
}


-(void) makeNormalSize:(CCTime)dt
{
    
    [_ball setScale:_ball.scale*0.7];
    _ball.physicsBody.density = 5.00f;
}

- (void) removeOnboarding
{
    CCLOG(@"Remove Onboarding Called");
    //Add it to the physics node if not added
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    [_physicsNode addChild:_ball];
    [_onboardNode removeFromParentAndCleanup:true];
}

- (void) nextOnboarding
{
    [_onboardNode removeAllChildrenWithCleanup:true];
    //Load Onboarding #2
    Onboard *_onTwo = (Onboard*) [CCBReader load:@"OnboardTwo" owner:self];
    _onTwo.position = ccp(0,0);
    [_onboardNode addChild:_onTwo];
    
}

- (NSString *) getCurrentTime
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}


@end
