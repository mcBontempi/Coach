#import <UIKit/UIKit.h>

#import "IconSelectionViewDelegate.h"
#import "SlotCreateCellDelegate.h"

@interface SlotCreateCell : UITableViewCell <IconSelectionViewDelegate>

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCreateCellDelegate>) delegate;
- (void) setup;

@end
