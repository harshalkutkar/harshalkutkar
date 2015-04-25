//
//  WinDialog.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/29/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WinDialog.h"
#import "GameManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation WinDialog
{
    CCLabelTTF *_score;
}

- (void)didLoadFromCCB {
    
    int points = [[GameManager sharedGameManager] getPoints];
    _score.string = [NSString stringWithFormat:@"%d", points];
    
}


-(void) share {
    
   
    [[CCDirector sharedDirector] pause];
    
     FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
     
     // this should link to FB page for your app or AppStore link if published
     content.contentURL = [NSURL URLWithString:@"http://harshalkutkar.com/donut-rush/"];
     // URL of image to be displayed alongside post
     content.imageURL = [NSURL URLWithString:@"http://harshalkutkar.com/donut-rush/img/preview.jpg"];
     // title of post
     int points = [[GameManager sharedGameManager] getPoints];
     int current = [[GameManager sharedGameManager] getCurrentLevel];
     
     content.contentTitle = [NSString stringWithFormat:@"My Donut Rush Score is %d on Level %d! ", points, current];
     // description/body of post
     content.contentDescription = @"Check out Donut Rush and See if you can beat me!";
     
     [FBSDKShareDialog showFromViewController:[CCDirector sharedDirector]
     withContent:content
     delegate:nil];
   
    
    
}



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

- (void)applicationWillResignActive:(UIApplication *)application {
    [[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {    
    [[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
    [[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
    [[CCDirector sharedDirector] startAnimation];
}



@end
