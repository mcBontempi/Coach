#import <UIKit/UIKit.h>
#import "EffortViewControllerDelegate.h"

@interface EffortViewController : UIViewController

@property (nonatomic, weak) id<EffortViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<EffortViewControllerDelegate>) delegate;

@end