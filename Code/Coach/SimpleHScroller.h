#import <UIKit/UIKit.h>
#import "SimpleHScrollerDelegate.h"

@interface SimpleHScroller : UIScrollView <UIScrollViewDelegate>

- (id)initWithPoint:(CGPoint)point items:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate;
- (void) setupWithDuration:(NSInteger) duration;

@end
