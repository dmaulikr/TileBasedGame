//
//  HUDNode.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "HUDNode.h"
#import "SharedTextureCache.h"

@interface HUDNode ()

@property (nonatomic) SKSpriteNode *lifeBar;
@property (nonatomic) SKSpriteNode *lifeBarImage;

@property (nonatomic) SKSpriteNode *leftButton;
@property (nonatomic) SKSpriteNode *rightButton;
@property (nonatomic) SKSpriteNode *jumpButton;

@property (nonatomic) NSArray *buttons;

@property (nonatomic) BOOL jumpButtonPressed;
@property (nonatomic) BOOL leftButtonPressed;
@property (nonatomic) BOOL rightButtonPressed;

@end

@implementation HUDNode

- (instancetype)initWithSize:(CGSize)size {

  if ((self = [super init])) {

    self.userInteractionEnabled = YES;

    self.lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"Life_Bar"];

    self.lifeBar.position = CGPointMake(70, size.height - 40);

    self.lifeBar.color = [SKColor colorWithRed:250.0/255.0 green:42.0/255.0 blue:0.0/255.0 alpha:1.0];

    self.lifeBar.colorBlendFactor = 0.3;

    [self addChild:self.lifeBar];

    SKAction *scaleUpAction = [SKAction scaleTo:1.2 duration:0.09];

    SKAction *scaleDownAction = [SKAction scaleTo:0.97 duration:0.09];

    SKAction *wait = [SKAction waitForDuration: 0.4];

    SKAction *pulse = [SKAction sequence:@[scaleUpAction, scaleDownAction, wait, scaleUpAction, scaleDownAction]];

    [self.lifeBar runAction:[SKAction repeatActionForever:pulse]];

    self.lifeBarImage = [SKSpriteNode spriteNodeWithImageNamed:@"Life_Bar_5_5"];

    self.lifeBarImage.position = CGPointMake(110, size.height - 40);

    self.lifeBarImage.color = [SKColor colorWithRed:250.0/255.0 green:42.0/255.0 blue:0.0/255.0 alpha:1.0];

    self.lifeBarImage.colorBlendFactor = 0.9;

    [self addChild:self.lifeBarImage];

    self.leftButton = [SKSpriteNode spriteNodeWithImageNamed:@"leftButton"];

    self.leftButton.position = CGPointMake(60, 95);

    self.leftButton.color = [SKColor colorWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1.0];

    self.leftButton.colorBlendFactor = 0.8;

    self.leftButton.alpha = 1.0;

    [self addChild:self.leftButton];

    self.rightButton = [SKSpriteNode spriteNodeWithImageNamed:@"rightButton"];

    self.rightButton.position = CGPointMake(140, 50);

    self.rightButton.color = [SKColor colorWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1.0];

    self.rightButton.colorBlendFactor = 0.8;

    self.rightButton.alpha = 1.0;

    [self addChild:self.rightButton];

    self.jumpButton = [SKSpriteNode spriteNodeWithImageNamed:@"jumpButton"];

    self.jumpButton.position = CGPointMake(size.width - 70, 60);

    self.jumpButton.color = [SKColor colorWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1.0];

    self.jumpButton.colorBlendFactor = 0.8;

    self.jumpButton.alpha = 1.0;

    [self addChild:self.jumpButton];

    self.buttons = @[self.leftButton, self.rightButton, self.jumpButton];

  }

  return self;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  for (UITouch *touch in touches) {

    CGPoint touchLocation = [touch locationInNode:self];

    for (SKSpriteNode *button in self.buttons) {

      if (CGRectContainsPoint(CGRectInset(button.frame, -25, -50), touchLocation)) {

        if (button == self.jumpButton) {

          [self sendJump:YES];

        } else if (button == self.rightButton) {

          [self sendDirection:kJoyDirectionRight];

        } else if (button == self.leftButton) {

          [self sendDirection:kJoyDirectionLeft];

        }
      }
    }
  }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

  for (UITouch *touch in touches) {

    CGPoint touchLocation = [touch locationInNode:self];

    CGPoint previousTouchLocation = [touch previousLocationInNode:self];

    for (SKSpriteNode *button in self.buttons) {

      if (CGRectContainsPoint(button.frame, previousTouchLocation) && !CGRectContainsPoint(button.frame, touchLocation)) {

        if (button == self.jumpButton) {


          [self sendJump:NO];

        } else {

          [self sendDirection:kJoyDirectionNone];

        }
      }
    }

    for (SKSpriteNode *button in self.buttons) {

      if (!CGRectContainsPoint(button.frame, previousTouchLocation) && CGRectContainsPoint(button.frame, touchLocation)) {

        if (button == self.rightButton) {


          [self sendDirection:kJoyDirectionRight];

        } else if (button == self.leftButton) {

          [self sendDirection:kJoyDirectionLeft];

        }
      }
    }
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

  for (UITouch *touch in touches) {

    CGPoint touchLocation = [touch locationInNode:self];

    for (SKSpriteNode *button in self.buttons) {

      if (CGRectContainsPoint(CGRectInset(button.frame, -25, -50), touchLocation)) {

        if (button == self.jumpButton) {

          [self sendJump:NO];

        } else {

          [self sendDirection:kJoyDirectionNone];

        }
      }
    }
  }
}

- (void)sendJump:(BOOL)jumpOn {

  if (jumpOn) {

    self.jumpButtonPressed = YES;

    [self.jumpButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"jumpButtonPressed"]];

  } else {

    self.jumpButtonPressed = NO;

    [self.jumpButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"jumpButton"]];

  }
}

- (void)sendDirection:(JoystickDirection)direction {

  if (direction == kJoyDirectionLeft) {

    self.leftButtonPressed = YES;

    self.rightButtonPressed = NO;

    [self.leftButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"leftButtonPressed"]];

    [self.rightButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"rightButton"]];

  } else if (direction == kJoyDirectionRight) {

    self.rightButtonPressed = YES;

    self.leftButtonPressed = NO;

    [self.rightButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"rightButtonPressed"]];

    [self.leftButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"leftButton"]];

  } else {

    self.rightButtonPressed = NO;

    self.leftButtonPressed = NO;

    [self.rightButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"rightButton"]];
    
    [self.leftButton setTexture:[[SharedTextureCache sharedCache] textureNamed:@"leftButton"]];

  }
}

- (JumpButtonState)jumpState {

  if (self.jumpButtonPressed) {

    return kJumpButtonOn;
  }

  return kJumpButtonOff;
}

- (JoystickDirection)joyDirection {

  if (self.leftButtonPressed) {

    return kJoyDirectionLeft;

  } else if (self.rightButtonPressed) {

    return kJoyDirectionRight;
  }

  return kJoyDirectionNone;

}

- (void)setLife:(CGFloat)life {

  int num = (int)(life * 5);

  NSString *lifeFrame = [NSString stringWithFormat:@"Life_Bar_%d_5", num];

  [self.lifeBarImage setTexture:[[SharedTextureCache sharedCache] textureNamed:lifeFrame]];

  [self.lifeBarImage setSize:self.lifeBarImage.texture.size];

}

@end
