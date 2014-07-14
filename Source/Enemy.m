//
//  Enemy.m
//  MGWUMinigameTemplate
//
//  Created by Rose on 7/13/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "Enemy.h"
#import "Projectile.h"

@implementation Enemy{
  CCTime _changeDirectionTimer; // the enemy changes direction going up and down when this timer reaches zero
  float _yVelocity;
}

-(id)init {
  if ((self = [super init])) {
    _changeDirectionTimer = (CCTime)(drand48());
    _yVelocity = 2;

    // the projectile array is used to store all the projectiles on screen
    _projectilesArray = [[NSMutableArray alloc]init];
  }
  return self;
}

-(void)update:(CCTime)delta{

  _changeDirectionTimer -= delta;
  if (_changeDirectionTimer <= 0){
    [self changeDirection];
    [self createProjectile];
  }
  
  float ypos = self.positionInPoints.y + _yVelocity;
  
  if(ypos <= [[CCDirector sharedDirector]viewSize].height * .25){
    ypos = 100;
  }else if (ypos >= [[CCDirector sharedDirector]viewSize].height * .75){
    ypos = 300;
  }
  
  [self setPositionInPoints:CGPointMake(self.positionInPoints.x, ypos)];
  
  Projectile * projectile;
  int i = 0;
  
  // this while loop will remove from the scene and the projectile array all of the projectiles that have moved off screen
  while (i < [_projectilesArray count]){
    projectile = [_projectilesArray objectAtIndex:i];
    float xpos = [self convertToWorldSpace:projectile.positionInPoints].x - 10;
    if(xpos <= -projectile.boundingBox.size.width){
      [projectile removeFromParent];
      [_projectilesArray removeObjectAtIndex:i];
    }
    i++;
  }
}

-(void) changeDirection{
  _yVelocity *= -1;
  _changeDirectionTimer = (CCTime)(drand48() * 2 + 1);
}

-(void) createProjectile{
  Projectile * projectile = (Projectile *)[CCBReader load:@"Projectile"];
  [projectile setPositionInPoints: CGPointMake(0, 0)];
  [projectile.physicsBody applyForce:CGPointMake(-50000, 0)];
  [self addChild: projectile];
  [_projectilesArray addObject:projectile];
  [self.animationManager runAnimationsForSequenceNamed:@"AnimFire"];
}

@end
