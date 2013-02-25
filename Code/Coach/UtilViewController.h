#import <UIKit/UIKit.h>
#import "UtilViewControllerDelegate.h"

@interface UtilViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;

    @property (nonatomic, weak) id<UtilViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<UtilViewControllerDelegate>) delegate;

@end
