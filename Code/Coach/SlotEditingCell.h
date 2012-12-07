#import <UIKit/UIKit.h>

#import "IconSelectionViewDelegate.h"
#import "SlotEditingCellDelegate.h"
#import "SimpleHScrollerDelegate.h"
#import "MultipleIconSelectionViewDelegate.h"

@interface SlotEditingCell : UITableViewCell <IconSelectionViewDelegate, SimpleHScrollerDelegate, MultipleIconSelectionViewDelegate>

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotEditingCellDelegate>) delegate;
-(void) setupWithDuration:(NSInteger)duration activityType:(TActivityType)activityType;

@end
