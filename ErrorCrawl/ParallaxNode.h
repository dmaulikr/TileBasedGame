//
//  ParallaxNode.h
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

@interface ParallaxNode : SKNode

@property (nonatomic) SKNode *rootNode;

- (void)update;

- (void)addChild:(SKNode*)child z:(CGFloat)zOrder parallaxRatio:(CGPoint)ratio positionOffset:(CGPoint)offset;

@end