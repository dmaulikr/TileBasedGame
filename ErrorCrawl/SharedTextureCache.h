//
//  SharedTextureCache.h
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SharedTextureCache : NSObject

+ (instancetype)sharedCache;

- (SKTexture *)textureNamed:(NSString *)name;

- (void)addTexture:(SKTexture *)texture name:(NSString *)textureName;

@end
