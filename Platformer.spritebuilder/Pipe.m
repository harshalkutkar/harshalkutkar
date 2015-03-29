//
//  Pipe.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Pipe.h"

@implementation Pipe

- (void)didLoadFromCCB {
    
    NSLog(@"Pipe Instantiated");
    
    //setting up the physics body
    self.physicsBody.collisionType = @"pipe";
}

@end
