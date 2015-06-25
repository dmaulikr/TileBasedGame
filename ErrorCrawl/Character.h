//
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "GameObject.h"
#import "SKTUtils.h"

typedef NS_ENUM(NSInteger, CharacterState) {
  kStateJumping,
  kStateDoubleJumping,
  kStateWalking,
  kStateStanding,
  kStateDying,
  kStateFalling,
  kStateDead,
  kStateWallSliding,
  kStateAttacking,
  kStateSeeking,
  kStateHiding
};

@interface Character : GameObject

@property (nonatomic) CGPoint velocity;
@property (nonatomic) CGPoint desiredPosition;
@property (nonatomic) BOOL onGround;
@property (nonatomic) CharacterState characterState;
@property (nonatomic) BOOL onWall;
@property (nonatomic) BOOL isActive;
@property (nonatomic) NSInteger life;
@property (nonatomic) SKAction *dyingAnim;

- (void)update:(NSTimeInterval)dt;

- (CGRect)collisionBoundingBox;

- (void)tookHit:(Character *)character;

- (void)changeState:(CharacterState)newState;

@end














