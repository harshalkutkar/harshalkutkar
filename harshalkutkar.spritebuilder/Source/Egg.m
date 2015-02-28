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
    isAlive = true;
    
}

- (void) crackEgg {
    CCAnimationManager* animationManager = self.animationManager;
    [animationManager runAnimationsForSequenceNamed:@"Crack"];


}

- (void) crackedEgg {
    isAlive = false;
    [self removeFromParentAndCleanup:true];
}

@end
