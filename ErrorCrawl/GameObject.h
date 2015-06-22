//
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SharedTextureCache.h"

@interface GameObject : SKSpriteNode

@property (nonatomic, assign) BOOL flipX;

- (SKAction *)loadAnimationFromPlist:(NSString *)animationName forClass:(NSString *)className;

- (void)loadAnimations;

@end
