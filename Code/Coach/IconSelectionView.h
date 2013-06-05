#import <UIKit/UIKit.h>
#import "IconSelectionViewDelegate.h"

@interface IconSelectionView : UIView

- (id)initWithPoint:(CGPoint)point images:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<IconSelectionViewDelegate>) delegate numCols:(NSUInteger)numCols;

-(void) setSelectedIndex:(NSInteger) selectedIndex;
- (void)setupWithImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<IconSelectionViewDelegate>) delegate numCols:(NSUInteger)numCols;

@property (nonatomic) NSInteger currentItemIndex;

@end
