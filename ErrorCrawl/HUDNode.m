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

@property (nonatomic, strong) SKSpriteNode *lifeBarImage;

@property (nonatomic, strong) SKSpriteNode *leftButton;
@property (nonatomic, strong) SKSpriteNode *rightButton;
@property (nonatomic, strong) SKSpriteNode *jumpButton;

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, assign) BOOL jumpButtonPressed;
@property (nonatomic, assign) BOOL leftButtonPressed;
@property (nonatomic, assign) BOOL rightButtonPressed;

@end

@implementation HUDNode

- (instancetype)initWithSize:(CGSize)size {
  //1
  if ((self = [super init])) {
    //2
    self.userInteractionEnabled = YES;
    //3
    self.lifeBarImage = [SKSpriteNode spriteNodeWithImageNamed:@"Life_Bar_5_5"];
    self.lifeBarImage.position = CGPointMake(80, size.height - 40);

    self.lifeBarImage.color = [SKColor colorWithRed:152.0/255.0 green:1.0/255.0 blue:1.0/255.0 alpha:1.0];
    self.lifeBarImage.colorBlendFactor = 0.9;

    [self addChild:self.lifeBarImage];

    SKAction *scaleUpAction = [SKAction scaleTo:1.07 duration:0.13];

    SKAction *scaleDownAction = [SKAction scaleTo:0.98 duration:0.13];

    SKAction *pulse = [SKAction sequence:@[scaleUpAction, scaleDownAction]];

    [self.lifeBarImage runAction:[SKAction repeatActionForever:pulse]];

    self.leftButton = [SKSpriteNode spriteNodeWithImageNamed:@"leftButton"];
    self.leftButton.position = CGPointMake(50, 90);

    [self addChild:self.leftButton];
    //5
    self.rightButton = [SKSpriteNode spriteNodeWithImageNamed:@"rightButton"];
    self.rightButton.position = CGPointMake(130, 90);
    [self addChild:self.rightButton];
    //6
    self.jumpButton = [SKSpriteNode spriteNodeWithImageNamed:@"jumpButton"];
    self.jumpButton.position = CGPointMake(size.width - 70, 60);

    self.jumpButton.color = [SKColor colorWithRed:62.0/255.0 green:62.0/255.0 blue:62.0/255.0 alpha:1.0];
    self.jumpButton.colorBlendFactor = 0.7;

    self.jumpButton.alpha = 0.9;

    [self addChild:self.jumpButton];
    //7
    self.buttons = @[self.leftButton, self.rightButton, self.jumpButton];
  }
  return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  //1
  for (UITouch *touch in touches) {
    //2
    CGPoint touchLocation = [touch locationInNode:self];
    //3
    for (SKSpriteNode *button in self.buttons) {
      if (CGRectContainsPoint(CGRectInset(button.frame, -25, -50), touchLocation)) {
        //4
        if (button == self.jumpButton) {
          [self sendJump:YES];
          //5
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
    //1
    CGPoint touchLocation = [touch locationInNode:self];

    CGPoint previousTouchLocation = [touch previousLocationInNode:self];

    for (SKSpriteNode *button in self.buttons) {
      //2
      if (CGRectContainsPoint(button.frame, previousTouchLocation) && !CGRectContainsPoint(button.frame, touchLocation)) {
        //3
        if (button == self.jumpButton) {

          [self sendJump:NO];
        } else {

          [self sendDirection:kJoyDirectionNone];
        }
      }
    }
    //4
    for (SKSpriteNode *button in self.buttons) {

      if (!CGRectContainsPoint(button.frame, previousTouchLocation) && CGRectContainsPoint(button.frame, touchLocation)) {
        
        //5
        //We don't get another jump on a slide-on, we want the
        //player to let go of the button for another jump

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
          //2
        } else {
          [self sendDirection:kJoyDirectionNone];
        }
      }
    }
  }
}

- (void)sendJump:(BOOL)jumpOn {
  //1
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
  //1
  int num = (int)(life * 5);
  //2
  NSString *lifeFrame = [NSString stringWithFormat:@"Life_Bar_%d_5", num];
  //3
  [self.lifeBarImage setTexture:[[SharedTextureCache sharedCache] textureNamed:lifeFrame]];
  //4
  [self.lifeBarImage setSize:self.lifeBarImage.texture.size];
}

@end









































