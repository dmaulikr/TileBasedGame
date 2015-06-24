//
//  Player.h
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Character.h"
#import "HUDNode.h"

@interface Player : Character

@property (nonatomic, weak) HUDNode *hud;

- (void)bounce;

@end
