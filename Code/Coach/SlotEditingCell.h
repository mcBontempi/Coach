#import <UIKit/UIKit.h>

#import "IconSelectionViewDelegate.h"
#import "SlotEditingCellDelegate.h"
#import "SimpleHScrollerDelegate.h"

@interface SlotEditingCell : UITableViewCell <IconSelectionViewDelegate, SimpleHScrollerDelegate>

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotEditingCellDelegate>) delegate;
-(void) setupWithDuration:(NSInteger)duration activityType:(TActivityType)activityType zone:(TZone) zone;

@end
