#import <UIKit/UIKit.h>
#import "SlotCellDelegate.h"

@interface SlotCell : UITableViewCell

@property NSInteger duration;
@property TActivityType activityType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
