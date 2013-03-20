#import <UIKit/UIKit.h>
#import "SimpleHScrollerDelegate.h"
#import "PagingScrollView.h"

@interface SimpleHScroller : PagingScrollView <UIScrollViewDelegate>

- (id)initWithPoint:(CGPoint)point items:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate;
- (void) setDuration:(NSInteger) duration;

- (void)setupWithItems:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate;

@end
