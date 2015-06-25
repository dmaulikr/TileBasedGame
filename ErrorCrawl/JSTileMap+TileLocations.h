
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "JSTileMap.h"

@interface JSTileMap (TileLocations)

- (CGRect)tileRectFromTileCoords:(CGPoint)tileCoords;

@end

@interface TMXLayer (TileLocations)

- (NSInteger)tileGIDAtTileCoord:(CGPoint)point;

@end
