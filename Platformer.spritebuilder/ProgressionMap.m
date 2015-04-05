//
//  ProgressionMap.m
//  Platformer
//
//  Created by Harsh Alkutkar on 4/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "ProgressionMap.h"
#import "GameManager.h"

@implementation ProgressionMap

-(void) startLevel:(CCButton *)sender
{
    
    //Get the current
    int currentLevel = [sender.title intValue];
    
    //Construct Name
    NSString *myString = @"Level";
    NSString *levelToLoad = [myString stringByAppendingString:[NSString stringWithFormat:@"%d", currentLevel]];
    
    NSLog(@"Loading level %@",levelToLoad);
    //set the same in GameManager
    [[GameManager sharedGameManager] setKeys:0 ];
     [[GameManager sharedGameManager] setCurrentLevel:currentLevel ];

    //Now Load CCB
    CCScene *scene =  [CCBReader loadAsScene:levelToLoad];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
    
}
@end
