#import <UIKit/UIKit.h>
#import "IconSelectionViewDelegate.h"

@interface IconSelectionView : UIView

- (id)initWithFrame:(CGRect)frame andImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding selectedIndex:(NSInteger) selectedIndex delegate:(id<IconSelectionViewDelegate>) delegate;

@end
