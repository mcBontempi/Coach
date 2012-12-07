#import <UIKit/UIKit.h>
#import "SlotCellDelegate.h"

@interface SlotCell : UITableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate;

-(void) setupWithChecked:(BOOL) checked duration:(NSInteger)duration activityType:(TActivityType) activityType zone:(TZone) zone;

@end
