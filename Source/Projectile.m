//
//  Projectile.m
//  MGWUMinigameTemplate
//
//  Created by Rose on 7/13/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Projectile.h"


@implementation Projectile

-(void) update:(CCTime)delta{
 
}

-(void) didLoadFromCCB{
  self.physicsBody.collisionType = @"projectile";
}

@end
