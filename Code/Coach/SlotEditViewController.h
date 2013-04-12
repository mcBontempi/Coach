#import <UIKit/UIKit.h>
#import "SlotEditViewControllerDelegate.h"
#import "SimpleHScrollerDelegate.h"
#import "IconSelectionViewDelegate.h"

@interface SlotEditViewController : UIViewController <SimpleHScrollerDelegate, IconSelectionViewDelegate >

-(id) initWithDelegate:(id<SlotEditViewControllerDelegate>) delegate;

@end
