#import <UIKit/UIKit.h>

#import "IconSelectionViewDelegate.h"
#import "SlotCellDelegate.h"

@interface SlotEditingCell : UITableViewCell <IconSelectionViewDelegate>

@property NSInteger duration;
@property TActivityType activityType;
@property BOOL cellExpandedForEditing;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate;


@end
