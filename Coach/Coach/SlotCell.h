#import <UIKit/UIKit.h>

#import "IconSelectionViewDelegate.h"
#import "SlotCellDelegate.h"

@interface SlotCell : UITableViewCell <IconSelectionViewDelegate>

@property NSInteger duration;
@property TActivityType activityType;

-(void) setHeight:(CGFloat) height;
@property BOOL cellExpandedForEditing;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate;


@end
