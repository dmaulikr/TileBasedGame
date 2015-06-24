//
//  Enemy.h
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-23.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Character.h"
#import "Player.h"
#import "JSTileMap+TileLocations.h"

@interface Enemy : Character

@property (nonatomic, weak) Player *player;

- (void)removeSelf;

@end
