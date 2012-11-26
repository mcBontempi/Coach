#import <UIKit/UIKit.h>

@interface IconSelectionView : UIView

@property (nonatomic, strong) NSArray *images;
@property CGSize iconSize;
@property NSInteger padding;
@property NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame andImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding selectedIndex:(NSInteger) selectedIndex;

@end
