//
//  Fly.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Fly.h"

@implementation Fly

- (void)didLoadFromCCB {
    NSLog(@"Fly Loaded");
    self.physicsBody.collisionType = @"fly";
}

@end
