#import <UIKit/UIKit.h>
#import "ListViewControllerDelegate.h"
#import "ToListViewControllerDelegate.h"
#import "TimetablePopoverViewControllerDelegate.h"

@interface ListViewController : GeneralViewController  <ToListViewControllerDelegate, TimetablePopoverViewControllerDelegate>

    @property (nonatomic, weak) id<ListViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate;

@end
