#import <UIKit/UIKit.h>
#import "FinishViewControllerDelegate.h"
#import "ToFinishViewControllerDelegate.h"

@interface FinishViewController : UIViewController <ToFinishViewControllerDelegate>

@property (nonatomic, weak) id<FinishViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<FinishViewControllerDelegate>) delegate;

@end
