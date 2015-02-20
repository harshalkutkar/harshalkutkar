//
//  WinLoseDialog.m
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/19/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "WinLoseDialog.h"
#import "GamePlay.h"

@implementation WinLoseDialog {
    CCLabelTTF *_dialogMsg;
}

@synthesize message;

- (void) setName:(NSString *)n {
    message = n;
   
}
- (void)didLoadFromCCB {
    [_dialogMsg setString:message];
    
    //Get the Midpoint
    CGSize winSize = [[CCDirector sharedDirector] viewSize];
    CGPoint point = ccp(winSize.width/2, winSize.height/2);
    [self setAnchorPoint:ccp(0.5, 0.5)];
    [self setPosition:point];
}

-(void) restart{
    [[GamePlay sharedInstance] restart];
}


@end
