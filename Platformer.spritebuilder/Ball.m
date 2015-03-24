//
//  Ball.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/21/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Ball.h"
#import <CoreMotion/CoreMotion.h>
#import "CCPhysics+ObjectiveChipmunk.h"

@implementation Ball
{
    CMMotionManager *_motionManager;
}

- (id)init {
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)didLoadFromCCB {
    _motionManager = [[CMMotionManager alloc] init];
    NSLog(@"Ball Instantiated");
    
    //setting up the physics body
    self.physicsBody.collisionType = @"ball";
}

#pragma Accelerometer
/*
 *  Accelerometer Functionality
 */

- (void)onEnter
{
    [super onEnter];
    [_motionManager startAccelerometerUpdates];
}
- (void)onExit
{
    [super onExit];
    [_motionManager stopAccelerometerUpdates];
}
// --- End of accelerometer


-(void) update:(CCTime)delta
{
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    CGSize s = [CCDirector sharedDirector].viewSize;
    
    /*
     CGFloat newXPosition = _ball.position.x + acceleration.y * 1000 * delta;
     newXPosition = clampf(newXPosition, 0, s.width);
     _ball.position = CGPointMake(newXPosition, _ball.position.y);
     */
    
    //acceleration in the X direction = the impulse being appplied. Works OK.
    [self.physicsBody applyImpulse:ccp(acceleration.x, 0.0f )];
    
 
    
    
    //sanity check
    /*
    CGFloat newXPosition = clampf(self.position.x, 0, s.width);
    CGFloat newYPosition = clampf(self.position.y, 0, s.height);
     self.position = ccp(newXPosition,newYPosition);
    */
    
    
    
    
    
    //print out ball position
    //NSLog(@"Ball Pos %f %f",self.position.x,self.position.y);
    
    
}




@end
