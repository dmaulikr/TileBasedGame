//
//  ErrorCrawl
//
//  Created by Vineet Tiwari on 2015-06-21.
//  Copyright (c) 2015 vinny.co. All rights reserved.
//

#import "Character.h"

@implementation Character

- (void)update:(NSTimeInterval)dt {

  //override this method
}

- (CGRect)collisionBoundingBox {

  CGPoint diff = CGPointSubtract(self.desiredPosition, self.position);
  return CGRectOffset(self.frame, diff.x, diff.y);
}

- (void)changeState:(CharacterState)newState {

  //override this method
}

@end
