//
//  LoseDialog.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/27/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "LoseDialog.h"
#import "GameManager.h"



@implementation LoseDialog
{
  CCLabelTTF *_score;
}

- (void)didLoadFromCCB {
    
    int points = [[GameManager sharedGameManager] getPoints];
    _score.string = [NSString stringWithFormat:@"%d", points];
    
}

-(void) restart
{
    //Get the current
    int current = [[GameManager sharedGameManager] getCurrentLevel];
    //Construct Name
    NSString *myString = @"Level";
    NSString *levelToLoad = [myString stringByAppendingString:[NSString stringWithFormat:@"%d", current]];
    //Now Load CCB
    CCScene *scene =  [CCBReader loadAsScene:levelToLoad];
    [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];
    
}

@end
