//
//  Egg.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Egg.h"

@implementation Egg
@synthesize isAlive;


- (void)didLoadFromCCB {
    NSLog(@"Egg Loaded");
    self.physicsBody.collisionType = @"egg";
    [self  setIsAlive:true];
    
}

- (void) crackEgg {
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Crack"];
    [self setIsAlive:false];

}

- (void) crackedEgg {
    isAlive = false;
    [self removeFromParentAndCleanup:true];
    
    
}

- (void) explodeLiveEgg
{
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Crack"];
    // load particle effect
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Explosion"];
    // make the particle effect clean itself up, once it is completed
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = self.position;
    // add the particle effect to the same node the seal is on
    [self.parent addChild:explosion];
    isAlive = false;


}




@end
