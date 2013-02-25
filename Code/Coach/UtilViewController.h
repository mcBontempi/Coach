#import <UIKit/UIKit.h>
#import "UtilViewControllerDelegate.h"
#import "UtilViewControllerProtocol.h"

@interface UtilViewController : UIViewController <UtilViewControllerProtocol>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

    @property (nonatomic, weak) id<UtilViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<UtilViewControllerDelegate>) delegate;

@end
