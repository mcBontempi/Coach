#import <UIKit/UIKit.h>
#import "DurationViewControllerDelegate.h"

@interface DurationViewController : UIViewController

@property (nonatomic, weak) id<DurationViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<DurationViewControllerDelegate>) delegate;

@end
