//
//  HUDNode.h
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_ENUM(NSInteger, JoystickDirection) {
  kJoyDirectionNone,
  kJoyDirectionLeft,
  kJoyDirectionRight
};

typedef NS_ENUM(NSInteger, JumpButtonState) {
  kJumpButtonOn,
  kJumpButtonOff
};

@interface HUDNode : SKNode

@property (nonatomic, readonly) JoystickDirection joyDirection;
@property (nonatomic, readonly) JumpButtonState jumpState;

- (instancetype)initWithSize:(CGSize)size;

- (void)setLife:(CGFloat)life;

@end










































