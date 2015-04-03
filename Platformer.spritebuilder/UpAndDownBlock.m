//
//  UpAndDownBlock.m
//  Platformer
//
//  Created by Harsh Alkutkar on 4/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "UpAndDownBlock.h"

@implementation UpAndDownBlock

@synthesize amount;

- (void)didLoadFromCCB {
    // if you have a rotating block variable
    
    [self runAction:[CCActionRepeatForever actionWithAction:
                       [CCActionSequence actions:
                        [CCActionMoveTo actionWithDuration:1.0 position:ccp([self position].x,[self position].y+amount)],
                        [CCActionMoveTo actionWithDuration:1.0 position:ccp([self position].x,[self position].y)],
                        nil
                        ]]];
}

@end
