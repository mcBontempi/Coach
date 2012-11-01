#import <UIKit/UIKit.h>
#import "ListViewControllerDelegate.h"
#import "ToListViewControllerDelegate.h"

@interface ListViewController : UIViewController  <ToListViewControllerDelegate>

    @property (nonatomic, weak) id<ListViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate;

@end
