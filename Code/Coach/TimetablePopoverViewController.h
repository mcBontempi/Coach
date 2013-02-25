#import <UIKit/UIKit.h>
#import "TimetablePopoverViewControllerDelegate.h"

@interface TimetablePopoverViewController : UIViewController

-(id) initWithDelegate:(id<TimetablePopoverViewControllerDelegate>) delegate;

@end
