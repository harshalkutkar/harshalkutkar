//
//  GamePlay.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay
{
     CCNode *_levelNode;
    CCScene *level;
}
 static GamePlay *sharedInstance = nil;

+ (instancetype)sharedInstance
{
    NSLog(@"Returning Instance");
  
    return sharedInstance;
}

- (id) init
{
    NSLog(@"Assigned Shared Instance");
    sharedInstance = self;
    self = [ super init ];
    
    //set time
    mTimeInSec = 0.0f;
    
    return( self );
    
    
}

- (void)didLoadFromCCB {
    //Load the level
    level = [CCBReader loadAsScene:@"MainScene"];
    [_levelNode addChild:level];
    [GamePlay sharedInstance];
   
}

- (void)restart {
    NSLog(@"Restart [ GamePlay ] ");
    [[CCDirector sharedDirector] resume];
    [_levelNode removeAllChildrenWithCleanup:true];
    
    [self didLoadFromCCB];
    
}





@end
