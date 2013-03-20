#import "PagingScrollView.h"

@implementation PagingScrollView

@synthesize responseInsets;

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint parentLocation = [self convertPoint:point toView:self.superview];
    CGRect responseRect = self.frame;
    responseRect.origin.x -= responseInsets.left;
    responseRect.origin.y -= responseInsets.top;
    responseRect.size.width += (responseInsets.left + responseInsets.right);
    responseRect.size.height += (responseInsets.top + responseInsets.bottom);

  BOOL retVal = CGRectContainsPoint(responseRect, parentLocation);
  
    return retVal;
}

@end