#import <UIKit/UIKit.h>
#import "WelcomeViewControllerDelegate.h"
#import "SlideToCancelViewController.h"

@interface WelcomeViewController : UIViewController <SlideToCancelDelegate>
    @property (nonatomic, weak) id<WelcomeViewControllerDelegate> delegate;
    -(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate;
@end
