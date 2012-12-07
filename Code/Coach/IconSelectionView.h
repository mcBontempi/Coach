#import <UIKit/UIKit.h>
#import "IconSelectionViewDelegate.h"

@interface IconSelectionView : UIView

- (id)initWithPoint:(CGPoint)point images:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<IconSelectionViewDelegate>) delegate;

-(void) setupWithSelectedIndex:(NSInteger) selectedIndex;

@end
