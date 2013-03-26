#import <UIKit/UIKit.h>
#import "SlotCellDelegate.h"

const CGFloat KNoteFieldWidth = 200;

extern UIFont * const KNoteFieldFont;

@interface SlotCell : UITableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate;

- (void)setupWithChecked:(BOOL) checked duration:(NSInteger)duration activityType:(TActivityType) activityType tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString *)coachNotes;

@end
