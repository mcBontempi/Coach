#import <UIKit/UIKit.h>
#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentToViewDelegate.h"

@interface TimetableViewController : UIViewController <TimetableViewAgentToViewDelegate>

@property (nonatomic, strong) NSMutableArray *weeks;

@property (nonatomic, weak) id<TimetableViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<TimetableViewControllerDelegate>) delegate;

@end
