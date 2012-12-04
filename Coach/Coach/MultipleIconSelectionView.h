#import <UIKit/UIKit.h>
#import "MultipleIconSelectionViewDelegate.h"

@interface MultipleIconSelectionView : UIView

- (id)initWithPoint:(CGPoint)point images:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<MultipleIconSelectionViewDelegate>) delegate;
-(void) setupWithSelectedIndexes:(NSArray *) selectedIndexesArray;
@end
