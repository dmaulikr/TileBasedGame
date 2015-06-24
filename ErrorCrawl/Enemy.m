//
//  Enemy.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-23.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

- (id)initWithImageNamed:(NSString *)name {

  if (self = [super initWithImageNamed:name]) {

    self.life = 100;
  }

  return self;
}

- (void)tookHit:(Character *)character {

  self.life = self.life - 100;

  if (self.life <= 0) {

    [self changeState:kStateDead];
  }
}

- (void)removeSelf {
  
  self.isActive = NO;
}


@end
