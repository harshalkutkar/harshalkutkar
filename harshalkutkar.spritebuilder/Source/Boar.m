//
//  Boar.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Boar.h"


@implementation Boar



@synthesize _updateTime;

- (void)didLoadFromCCB {
    NSLog(@"Boar Loaded");
    
    //set collision type
    self.physicsBody.collisionType = @"boar";
    
    //set default speed
    self.speed = 1.0;

}

- (float) getSpeed
{
    return speed;
}

- (void) setSpeed:(float) s
{
    speed = s;
}

-(void)update:(CCTime)delta
{
    // update: moves left and right
    _updateTime += delta;
    
    CGPoint velocity = CGPointMake(speed, 0); // Move right
    self.position = ccpAdd(self.position, velocity);
    
    
    /*
     CGPoint pos = self.position;
    pos.x += 10;
    self.position = pos;
     */
}

@end
