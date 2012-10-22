#import <UIKit/UIKit.h>
#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentDelegate.h"

@interface TimetableViewController : UIViewController <TimetableViewAgentDelegate>

@property (nonatomic, strong) NSMutableArray *weeks;

@property (nonatomic, weak) id<TimetableViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<TimetableViewControllerDelegate>) delegate;

@end
