#import <UIKit/UIKit.h>
#import "ListViewControllerDelegate.h"

@interface ListViewController : UIViewController

    @property (nonatomic, weak) id<ListViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate;

@end
