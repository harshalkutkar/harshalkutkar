//
//  Bird.h
//  harshalkutkar
//
//  Created by Harsh Alkutkar on 2/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Bird : CCSprite{
    float speed;
}

@property (nonatomic)     CCTime _updateTime;

- (void) setSpeed:(float) s;
- (float) getSpeed;

@end
