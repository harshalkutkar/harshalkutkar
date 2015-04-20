//
//  Gingerbread.m
//  Platformer
//
//  Created by Harsh Alkutkar on 4/20/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gingerbread.h"

@implementation Gingerbread

- (void)didLoadFromCCB {
    
    
    //setting up the physics body
    self.physicsBody.collisionType = @"gingerbread";
    self.physicsBody.sensor = true;
}

@end
