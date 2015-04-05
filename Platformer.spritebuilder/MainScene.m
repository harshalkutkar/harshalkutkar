//
//  MainScene.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

- (void) start
{
    CCScene *scene =  [CCBReader loadAsScene:@"Level1"];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
}

- (void) level
{
    CCScene *scene =  [CCBReader loadAsScene:@"ProgressionMap"];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
}
@end
