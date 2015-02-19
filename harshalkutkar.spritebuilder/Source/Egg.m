//
//  Egg.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Egg.h"

@implementation Egg

- (void)didLoadFromCCB {
    NSLog(@"Egg Loaded");
    self.physicsBody.collisionType = @"egg";
    
}
@end
