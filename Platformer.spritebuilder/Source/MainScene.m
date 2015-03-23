#import "MainScene.h"
#import <CoreMotion/CoreMotion.h>

#import "Ball.h"


@implementation MainScene
{
    Ball *_ball;
    CCNode *_physicsNode;
    CCSprite *_rotatingBlock;
    CCNode *_contentNode;
    
}

- (id)init {
    if (self = [super init])
    {
    }
    
    return self;
}


- (void)didLoadFromCCB {
    
    
    _ball = (Ball*) [CCBReader load:@"Ball"];
    _ball.position = ccp(162,558);
    [_physicsNode addChild:_ball];
    
    
    
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_ball];
    [self runAction:follow];
    
    
    self.userInteractionEnabled = YES;
    
    //get the size of screen
     CGSize s = [CCDirector sharedDirector].viewSize;
    
    
    // set the rotation
    CCActionRotateBy *rot = [CCActionRotateBy actionWithDuration:1 angle:360];
    
    
    [_rotatingBlock runAction:[CCActionRepeatForever actionWithAction:rot]];
    
 
    
}


- (void) update:(CCTime)delta
{
    //get the size of screen
    CGSize s = [CCDirector sharedDirector].viewSize;
    NSLog(@"Width: %f",s.width);
    //set the new position
    _rotatingBlock.position = ccp(_rotatingBlock.position.x+1, _rotatingBlock.position.y);
    if (_rotatingBlock.position.x > (s.width))
    {
        _rotatingBlock.position =  ccp(0,_rotatingBlock.position.y);
    }
    
    [self boundsCheck];
   
}

-(void) boundsCheck
{
    
    
    if (_ball.position.y < -550)
    {
        CCScene *scene =  [CCBReader loadAsScene:@"LoseDialog"];
        [[CCDirector sharedDirector] replaceScene: scene withTransition: [CCTransition transitionCrossFadeWithDuration: 0.5]];

    }
    
}




@end
