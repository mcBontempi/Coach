#import <UIKit/UIKit.h>
#import "UtilViewControllerDelegate.h"

@interface UtilViewController : GeneralViewController

    @property (nonatomic, weak) id<UtilViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<UtilViewControllerDelegate>) delegate;

@end
