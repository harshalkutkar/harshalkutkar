//
//  GamePlay.h
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCScene.h"

@interface GamePlay : CCNode
{
      float                mTimeInSec;
}

+ (instancetype)sharedInstance;
- (void) restart;
- (void) showWinLoseDialog : (NSString *) string;

@end
