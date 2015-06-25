//
//  GameViewController.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "GameViewController.h"
#import "LevelScene.h"

@interface GameViewController () <SceneDelegate>

@property (nonatomic) NSMutableArray *observers;

@end

@implementation GameViewController

- (void)viewWillLayoutSubviews {

  [super viewWillLayoutSubviews];

  [self setupObservers];

  // Configure the view.
  SKView *skView = (SKView *)self.view;

  skView.showsFPS = YES;

  skView.showsNodeCount = YES;

  // Create and configure the scene.
  LevelScene *scene = [[LevelScene alloc] initWithSize:skView.bounds.size level:self.currentLevel];

  scene.scaleMode = SKSceneScaleModeAspectFill;

  scene.sceneDelegate = self;

  // Present the scene.
  [skView presentScene:scene];

}

- (BOOL)shouldAutorotate {

  return YES;

}

- (NSUInteger)supportedInterfaceOrientations {

  return UIInterfaceOrientationMaskLandscape;

}

- (void)setupObservers {

  self.observers = [NSMutableArray array];

  id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    SKView *skView = (SKView *)self.view;

    skView.paused = YES;

  }];

  [self.observers addObject:observer];

  observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    SKView *skView = (SKView *)self.view;

    skView.paused = YES;

  }];

  [self.observers addObject:observer];

  observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {

    SKView *skView = (SKView *)self.view;

    skView.paused = NO;

  }];

  [self.observers addObject:observer];
}

- (void)dealloc {

  for (id observer in self.observers) {

    [[NSNotificationCenter defaultCenter] removeObserver:observer];

  }
}

- (void)dismissScene {

  for (id observer in self.observers) {

    [[NSNotificationCenter defaultCenter] removeObserver:observer];

  }

  self.observers = nil;

  [self.navigationController popToRootViewControllerAnimated:YES];
  
}

@end













