//
//  GameScene.h
//  ErrorCrawl
//

//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol SceneDelegate <NSObject>

- (void)dismissScene;

@end

@interface LevelScene : SKScene

@property (nonatomic, weak) id <SceneDelegate> sceneDelegate;

- (id)initWithSize:(CGSize)size level:(NSUInteger)currentLevel;

@end
