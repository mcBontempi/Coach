#import <UIKit/UIKit.h>
#import "WelcomeViewControllerDelegate.h"

@interface WelcomeViewController : UIViewController

    @property (nonatomic, weak) id<WelcomeViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate;


@end
