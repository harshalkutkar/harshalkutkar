//
//  GameManager.h
//  Platformer
//
//  Created by Harsh Alkutkar on 3/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Portal.h"

@interface GameManager : NSObject

+ (GameManager *) sharedGameManager;
- (void) sayHello;
- (void) addKey;
- (int) getKeys;
- (void) setKeys: (int) x;
-(int) getRequiredKeysForLevel: (int) level;
- (int) getCurrentLevel;
- (void) setCurrentLevel : (int) level;
-(BOOL) checkIfPlayerHasRequiredKeysForLevel;
-(void) incrementLevel;
-(void) addPortal : (Portal*) p;
- (void) clearPortals;
- (CGPoint) getLocationOfPortal : (int) portalId;
- (int) getAngleOfPortal : (int) portalId;

@end
