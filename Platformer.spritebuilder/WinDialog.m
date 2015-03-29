//
//  WinDialog.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WinDialog.h"
#import "GameManager.h"

@implementation WinDialog

- (void) next
{
    //Increment Level
    [[GameManager sharedGameManager] incrementLevel];
    //Get the next number
    int current = [[GameManager sharedGameManager] getCurrentLevel];
    //Construct Name
    NSString *myString = @"Level";
    NSString *levelToLoad = [myString stringByAppendingString:[NSString stringWithFormat:@"%d", current]];
    //Now Load CCB
    CCScene *scene =  [CCBReader loadAsScene:levelToLoad];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
    
}

@end
