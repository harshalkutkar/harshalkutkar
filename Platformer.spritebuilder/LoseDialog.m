//
//  LoseDialog.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LoseDialog.h"

@implementation LoseDialog

-(void) restart
{
    CCScene *scene =  [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
}

@end
