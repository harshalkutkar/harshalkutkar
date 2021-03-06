//
//  Portal.m
//  Platformer
//
//  Created by Harsh Alkutkar on 4/4/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Portal.h"
#import "GameManager.h"

@implementation Portal

@synthesize portalId;
@synthesize connectedPortalId;
@synthesize portalAngle;

- (void)didLoadFromCCB {
    //register as portal. (hopefully id is set in spritebuilder);
    [[GameManager sharedGameManager] addPortal:self];
    //self.physicsBody.sensor = true;
}

- (CGPoint) returnLocation
{
    return self.position;
}

- (int) getPortalId
{
    return portalId;
}

-(int) getConnectedPortalId
{
    return connectedPortalId;
}

- (int) getAngleOfPortal
{
    return portalAngle;
}


@end
