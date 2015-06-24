//
//  Crawler.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-23.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Crawler.h"

#define kCrawlerWidth 32
#define kCrawlerHeight 32

#define kMovementSpeed 60

@interface Crawler ()

@property (nonatomic) SKAction *walkingAnim;

@end

@implementation Crawler

- (void)loadAnimations {
  self.walkingAnim = [self loadAnimationFromPlist:@"walkingAnim" forClass:@"Crawler"];
  self.dyingAnim = [self loadAnimationFromPlist:@"dyingAnim" forClass:@"Crawler"];
}

- (void)update:(NSTimeInterval)dt {
  if (self.characterState == kStateDead) {
    self.desiredPosition = self.position;
    return;
  }

  CGFloat distance = CGPointDistance(self.position, self.player.position);
  if (distance > 1000) {
    self.desiredPosition = self.position;
    self.isActive = NO;
    return;
  } else {
    self.isActive = YES;
  }

  if (self.onGround) {
    [self changeState:kStateWalking];
    if (self.flipX) {
      self.velocity = CGPointMake(kMovementSpeed, 0);
    } else {
      self.velocity = CGPointMake(-kMovementSpeed, 0);
    }
  } else {
    [self changeState:kStateFalling];
    self.velocity = CGPointMake(self.velocity.x * 0.98, self.velocity.y);
  }
  if (self.onWall) {
    self.velocity = CGPointMake(-self.velocity.x, self.velocity.y);
    if (self.velocity.x > 0) {
      self.flipX = YES;
    } else {
      self.flipX = NO;
    }
  }

  CGPoint gravity = CGPointMake(0.0, -450.0);
  CGPoint gravityStep = CGPointMultiplyScalar(gravity, dt);

  self.velocity = CGPointAdd(self.velocity, gravityStep);
  self.desiredPosition = CGPointAdd(self.position, CGPointMultiplyScalar(self.velocity, dt));
}

- (CGRect)collisionBoundingBox {
  return CGRectMake(
                    self.desiredPosition.x - (kCrawlerWidth / 2),
                    self.desiredPosition.y - (kCrawlerHeight / 2),
                    kCrawlerWidth, kCrawlerHeight);
}

- (void)changeState:(CharacterState)newState {
  if (newState == self.characterState) return;
  [self removeAllActions];
  self.characterState = newState;

  SKAction *action = nil;
  switch (newState) {
    case kStateWalking: {
      action = [SKAction repeatActionForever:self.walkingAnim];
      break;
    }
    case kStateFalling: {
      [self setTexture:[[SharedTextureCache sharedCache] textureNamed:@"Crawler1.png"]];
      [self setSize:self.texture.size];
      break;
    }
    case kStateDead: {
      action = [SKAction sequence:@[self.dyingAnim, [SKAction performSelector:@selector(removeSelf) onTarget:self]]];
      break;
    }
    default:
      break;
  }
  if (action != nil) {
    [self runAction:action];
  }
}

@end
