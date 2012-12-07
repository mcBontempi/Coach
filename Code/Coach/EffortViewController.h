#import <UIKit/UIKit.h>
#import "EffortViewControllerDelegate.h"

@interface EffortViewController : GeneralViewController

@property (nonatomic, weak) id<EffortViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<EffortViewControllerDelegate>) delegate;

@end
