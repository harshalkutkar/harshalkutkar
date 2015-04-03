//
//  RotatingBlock.m
//  Platformer
//
//  Created by Harsh Alkutkar on 4/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "RotatingBlock.h"

@implementation RotatingBlock
@synthesize duration;

- (void)didLoadFromCCB {
    // if you have a rotating block variable
    CCActionRotateBy *rot = [CCActionRotateBy actionWithDuration:duration angle:360];
    [self runAction:[CCActionRepeatForever actionWithAction:rot]];
}





@end
