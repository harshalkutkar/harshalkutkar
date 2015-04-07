//
//  Portal.h
//  Platformer
//
//  Created by Harsh Alkutkar on 4/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Portal : CCSprite
//id of the portal.
@property (nonatomic,assign) int portalId;
@property (nonatomic,assign) int connectedPortalId;
@property (nonatomic,assign) int portalAngle;

- (CGPoint) returnLocation;
-(int) getConnectedPortalId;
-(int) getPortalId;
-(int) getAngleOfPortal;
-(void) setPortalAngle:(int)p;

@end
