//
//  Key.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Key.h"

@implementation Key

- (void)didLoadFromCCB {
    
    NSLog(@"Key Instantiated");
    
    //setting up the physics body
    self.physicsBody.collisionType = @"key";
}


@end
