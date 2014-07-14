//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MGWUMinigame.h"
#import "UIDMyCharacter.h"

@interface UIDMyMinigame : MGWUMinigame<CCPhysicsCollisionDelegate> 

// DO NOT DELETE!
@property (nonatomic,retain) UIDMyCharacter *hero;
// DO NOT DELETE!

@end
