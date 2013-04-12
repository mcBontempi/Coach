#import <UIKit/UIKit.h>
#import "TimetableViewControllerDelegate.h"
#import "ToTimetableViewControllerDelegate.h"
#import "SlotCellDelegate.h"
#import "SlotCreateCellDelegate.h"

@interface TimetableViewController : UIViewController <ToTimetableViewControllerDelegate, SlotCreateCellDelegate, SlotCellDelegate>

@property (nonatomic, strong) NSMutableArray *weeks;

@property (nonatomic, weak) id<TimetableViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<TimetableViewControllerDelegate>) delegate;

@end
