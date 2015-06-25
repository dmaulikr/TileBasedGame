//
//  JSTileMap+TileLocations.m
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "JSTileMap+TileLocations.h"

@implementation JSTileMap (TileLocations)

- (CGRect)tileRectFromTileCoords:(CGPoint)tileCoords {

  CGFloat levelHeightInPixels = self.mapSize.height * self.tileSize.height;

  CGPoint origin = CGPointMake(tileCoords.x * self.tileSize.width, levelHeightInPixels - (tileCoords.y + 1) * self.tileSize.height);

  return CGRectMake(origin.x, origin.y, self.tileSize.width, self.tileSize.height);

}

@end

@implementation TMXLayer (TileLocations)

- (NSInteger)tileGIDAtTileCoord:(CGPoint)point {

  return [self.layerInfo tileGidAtCoord:point];
  
}

@end 
