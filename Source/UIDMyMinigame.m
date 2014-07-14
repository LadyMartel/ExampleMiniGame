//
//  MGWUMinigameTemplate
//
//  Created by Zachary Barryte on 6/6/14.
//  Copyright 2014 Apportable. All rights reserved.
//

#import "UIDMyMinigame.h"
#import "Enemy.h"
#import "Projectile.h"

@implementation UIDMyMinigame{
  UIDMyCharacter* _character;
  Enemy * _enemy;
  CCPhysicsNode* _physicsNode;
  CCLabelTTF * _scoreLabel;
  
  // allows the user to jump only when the timer reaches zero
  CCTime jumpTimer;
  int score;
}

-(id)init {
  if ((self = [super init])) {
    // Initialize any arrays, dictionaries, etc in here
    score = 1;
    jumpTimer = 0;
  }
  return self;
}

-(void)didLoadFromCCB {
  // Set up anything connected to Sprite Builder here
  
  // Do this if you need to detect collisions:
  _physicsNode.collisionDelegate = self;
  
  // Do this to recieve user touch input:
  self.userInteractionEnabled = true;
  
  // Sets the starting text for the score label
  _scoreLabel.string = @"1/100";
}

-(void)onEnter {
  [super onEnter];
  // Create anything you'd like to draw here
}

-(void)update:(CCTime)delta {
  // This method is called each update cycle
  // n.b. Lag and other factors may cause it to be called more or less frequently on different devices or sessions
  // delta will tell you how much time has passed since the last cycle (in seconds)
  
  jumpTimer -= delta;
  if (_character.positionInPoints.y > [[CCDirector sharedDirector]viewSize].height - _character.boundingBox.size.height){
    [_character setPositionInPoints:CGPointMake(_character.positionInPoints.x, [[CCDirector sharedDirector]viewSize].height - _character.boundingBox.size.height)];
  }
  
}

/* This method is called when the user touches the screen.
 */
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
  if (jumpTimer <= 0){
    [_character jump];
    score += 5;
    _scoreLabel.string = [NSString stringWithFormat:@"%d/100", score];
    if(score >= 100){
      [self endMinigame];
    }
    jumpTimer = 1;
  }
}

/* This method recieves collisions. 
 * In this case, the two colliding types are hero and projectile.
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair*)pair hero:(UIDMyCharacter*) hero projectile:(Projectile*) projectile{
  [self endMinigame];
  return true;
}

-(void)endMinigame {
  // Report your score here! It must be between 1 and 100 (inclusive)
  [self endMinigameWithScore: score];
}

// DO NOT DELETE!
-(UIDMyCharacter *)hero {
  return (UIDMyCharacter *)self.character;
}
// DO NOT DELETE!

@end
