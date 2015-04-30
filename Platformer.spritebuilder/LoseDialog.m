//
//  LoseDialog.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LoseDialog.h"
#import "GameManager.h"
#import "Mixpanel.h"
#define MIXPANEL_TOKEN @"69eb3e9dde2cc4e5324b00727134192e"



@implementation LoseDialog
{
  CCLabelTTF *_score;
}

- (void)didLoadFromCCB {
    
    
    int points = [[GameManager sharedGameManager] getPoints];
    _score.string = [NSString stringWithFormat:@"%d", points];
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"sad.mp3" loop:NO];
    
    //Mixpanel Tracking
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];

    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel track:@"Lost a Level" properties:@{
                                                         @"Level": @([[GameManager sharedGameManager] getCurrentLevel]).stringValue,
                                                         @"Time":  [self getCurrentTime],
                                                         @"Score": @([[GameManager sharedGameManager] getPoints]).stringValue,
                                                         @"Keys Collected":@([[GameManager sharedGameManager] getKeys]).stringValue
                                                         }];
    
    
}

-(void) restart
{
    //stop all effects
    [[OALSimpleAudio sharedInstance] stopAllEffects];
    
    //Get the current
    int current = [[GameManager sharedGameManager] getCurrentLevel];
    //Construct Name
    NSString *myString = @"Level";
    NSString *levelToLoad = [myString stringByAppendingString:[NSString stringWithFormat:@"%d", current]];
    //Now Load CCB
    CCScene *scene =  [CCBReader loadAsScene:levelToLoad];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
    
}

- (NSString *) getCurrentTime
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm:ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    return resultString;
}


@end
