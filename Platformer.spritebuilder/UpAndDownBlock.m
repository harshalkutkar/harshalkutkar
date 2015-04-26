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
@synthesize angle;

- (void)didLoadFromCCB {
    // if you have a rotating block variable
    srand48(arc4random());
    
  
    
    if (angle == 180 || angle==0 )
    {
        double x = randomFloat(0.4f, 1.0f);
        CCLOG(@"Float %f",x);
        CCLOG(@"Angle 180");
        [self runAction:[CCActionRepeatForever actionWithAction:
                         [CCActionSequence actions:
                          [CCActionMoveTo actionWithDuration:x position:ccp([self position].x+amount,[self position].y)],
                          [CCActionMoveTo actionWithDuration:x position:ccp([self position].x-amount,[self position].y)],
                          nil
                          ]]];
    }
    else
    {
    
        double x = randomFloat(1.5f, 3.5f);
        
        [self runAction:[CCActionRepeatForever actionWithAction:
                       [CCActionSequence actions:
                        [CCActionMoveTo actionWithDuration:x position:ccp([self position].x,[self position].y+amount)],
                        [CCActionMoveTo actionWithDuration:x position:ccp([self position].x,[self position].y)],
                        nil
                        ]]];
    }
    
    
}

float randomFloat(float Min, float Max){
    return ((arc4random()%RAND_MAX)/(RAND_MAX*1.0))*(Max-Min)+Min;
}
@end
