//
//  ParallaxNode.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//  This code is copied from Cocos2d's CCParallaxNode class with some minor changes

#import "ParallaxNode.h"

@interface CGPointObject : NSObject

@property (nonatomic,readwrite) CGPoint ratio;
@property (nonatomic,readwrite) CGPoint offset;
@property (nonatomic, weak) SKNode *child;
+(id) pointWithCGPoint:(CGPoint)point offset:(CGPoint)offset;
-(id) initWithCGPoint:(CGPoint)point offset:(CGPoint)offset;
@end

@implementation CGPointObject

+(id) pointWithCGPoint:(CGPoint)ratio offset:(CGPoint)offset
{
  return [[self alloc] initWithCGPoint:ratio offset:offset];
}
-(id) initWithCGPoint:(CGPoint)ratio offset:(CGPoint)offset
{
  if( (self=[super init])) {
    self.ratio = ratio;
    self.offset = offset;
  }
  return self;
}
@end

@interface ParallaxNode()

@property (nonatomic) NSMutableArray *subParallaxNodes;

@end

@implementation ParallaxNode

- (id)init
{
  if (self = [super init]) {
    self.subParallaxNodes = [NSMutableArray array];

    [self runAction:[SKAction repeatActionForever:[SKAction customActionWithDuration:1.0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
      [self update];
    }]]];
  }
  return self;
}

- (CGPoint)absolutePosition
{
  return [self convertPoint:self.position toNode:self.rootNode];
}

-(void)addChild:(SKNode*)child z:(CGFloat)zOrder parallaxRatio:(CGPoint)ratio positionOffset:(CGPoint)offset
{
  NSAssert( child != nil, @"Argument must be non-nil");
  CGPointObject *obj = [CGPointObject pointWithCGPoint:ratio offset:offset];
  obj.child = child;
  [self.subParallaxNodes addObject:obj];

  CGPoint pos = self.position;
  pos.x = pos.x * ratio.x + offset.x;
  pos.y = pos.y * ratio.y + offset.y;
  child.position = pos;

  child.zPosition = zOrder;

  [super addChild:child];
}

-(void)removeChild:(SKNode*)node
{
  for(NSUInteger i=0; i < [self.subParallaxNodes count]; i++) {
    CGPointObject *point = self.subParallaxNodes[i];
    if( [point.child isEqual:node] ) {
      [self.subParallaxNodes removeObject:point];
      break;
    }
  }
  [super removeChildrenInArray:@[node]];
}

- (void)removeFromParent
{
  [self removeAllActions];
  NSMutableArray *nodes = [NSMutableArray array];
  for (CGPointObject *pointObj in self.subParallaxNodes) {
    [nodes addObject:pointObj.child];
  }
  for (SKNode *node in nodes) {
    [node removeFromParent];
  }
  [self.subParallaxNodes removeAllObjects];
  [super removeFromParent];
}

- (void)update
{
  if (![self.subParallaxNodes count]) return;
  CGPoint pos = [self absolutePosition];
  for(NSUInteger i=0; i < [self.subParallaxNodes count]; i++ ) {

    CGPointObject *point = self.subParallaxNodes[i];
    float x = -pos.x + pos.x * point.ratio.x + point.offset.x;
    float y = -pos.y + pos.y * point.ratio.y + point.offset.y;
    point.child.position = CGPointMake(x,y);
  }
}

- (SKNode *)rootNode
{
  if (!_rootNode) return self.scene;
  return _rootNode;
}

@end
