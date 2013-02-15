#import <UIKit/UIKit.h>
#import "PlanDetailViewControllerDelegate.h"

@interface PlanDetailViewController : UIViewController

    @property (nonatomic, weak) id<PlanDetailViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<PlanDetailViewControllerDelegate>) delegate;
- (IBAction)exportPressed:(id)sender;
- (IBAction)deletePressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *planNameLabel;

@end
