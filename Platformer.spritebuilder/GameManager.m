//
//  GameManager.m
//  Platformer
//
//  Created by Harsh Alkutkar on 3/28/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "GameManager.h"


@implementation GameManager
{
    int keys;
    int currentLevel;
    int points;
    NSMutableDictionary *keyRequirement;
    NSMutableArray *portalArray;
 
}

static GameManager* _sharedMySingleton = nil;


+(GameManager*)sharedGameManager {
    @synchronized([GameManager class])
    {
        if (!_sharedMySingleton)
            _sharedMySingleton =  [[self alloc] init];
        
        return _sharedMySingleton;
    }
    return nil;
}

+(id)alloc
{
    @synchronized([GameManager class])
    {   NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedMySingleton = [super alloc]; return _sharedMySingleton;
    }
    
    return nil;
}

-(id)init {
    NSLog (@"INIT CALLED");
    
    self = [super init];
    if (self != nil) {
        // initialize stuff here
        
        [self initRequirementDict];
        [self setCurrentLevel:1];
        [self setKeys:0];
       
        
    }
    return self;
}

- (void) initRequirementDict
{
    //initialize mutable dict
    keyRequirement =  [[NSMutableDictionary alloc] init];
    
    //initialize mutable dict for portals
    portalArray =  [[NSMutableArray alloc] init];
   
    //level 1 needs one key [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:1]];
    
    //level 2 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:2] forKey:[NSNumber numberWithInt:2]];
    
    //level 3 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:2] forKey:[NSNumber numberWithInt:3]];
    
    //level 4 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:2] forKey:[NSNumber numberWithInt:4]];
    
    //level 5 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:3] forKey:[NSNumber numberWithInt:5]];
    
    //level 6 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:2] forKey:[NSNumber numberWithInt:6]];
    
    
    //level 7 needs two keys [KEY-LEVEL PAIRS!!!]
    [keyRequirement setObject:[NSNumber numberWithInt:4] forKey:[NSNumber numberWithInt:7]];
    
    
    
}

-(void)sayHello {
    NSLog(@"Hello World!");
}

// Key Operations

/*
 * Gets Triggered when a key is collected. Adds one.
 */
-(void) addKey
{
    keys++;
    NSLog(@"GAMEMANAGER: Added a key: total %d",keys);
}

/*
 * Getter For number of current keys collected.
 */
-(int) getKeys
{
    return keys;
}

/*
 * Setter For number of current keys collected.
 */

-(void) setKeys: (int) x
{
    keys = x;
    NSLog (@"Setting Keys to %d | %d",x,keys);
}

/*
 * Given a level returns the required keys
 */
-(int) getRequiredKeysForLevel: (int) level
{
    NSNumber *required = [keyRequirement objectForKey:[NSNumber numberWithInt:level]];
    return [required intValue];
}

-(BOOL) checkIfPlayerHasRequiredKeysForLevel
{
   
    int required = [self getRequiredKeysForLevel:currentLevel];
     NSLog(@"Checking ig player has keys: Keys %d Required %d Level %d",keys,required,currentLevel);
    if (keys < required)
    {
        return FALSE;
    }
    return TRUE;
}

/*
 * Gets the current Level
 */
- (int) getCurrentLevel
{
    return currentLevel;
    
}

/*
 * Sets the current Level
 */
- (void) setCurrentLevel : (int) level
{
    currentLevel = level;
    NSLog (@"Current Level is now %d",currentLevel);
}

/*
 * Increment Level
 */

-(void) incrementLevel
{
    currentLevel = currentLevel+1;
    NSLog (@"Incremented Level to now %d",currentLevel);
}

/*
 *  Removes all the portals in the array.
 */
- (void) clearPortals
{
    [portalArray removeAllObjects];
}
/*
 *  This function registers a portal within a level.
 */
-(void) addPortal : (Portal*) p
{
    [portalArray addObject:p];
    NSLog(@"Portal Added To Array, id = %d",[p getPortalId]);
}
/*
 *
 */
- (CGPoint) getLocationOfPortal : (int) portalId
{
    for (Portal *portal in portalArray)
    {
         if ([portal getPortalId] == portalId)
         {
             //match found.
             NSLog(@"Portal Found %d",portalId);
             return [portal returnLocation];
         }
    }
    NSLog (@"No such portal found returning 0,0");
    return ccp(0.0f,0.0f);
}

//Probably could be combined with the above (//todo)

- (int) getAngleOfPortal : (int) portalId
{
    for (Portal *portal in portalArray)
    {
        if ([portal getPortalId] == portalId)
        {
            //match found.
            NSLog(@"Portal Found %d",portalId);
            return [portal getAngleOfPortal];
        }
    }
    NSLog (@"No such portal found");
    return 0;
}

//setting the points
-(void) setPoints : (int) p
{
    NSLog(@"Setting points = %d",p);
    points = p;
}

-(int) getPoints
{
    return  points;
}

@end
