#import <UIKit/UIKit.h>
#import "TypeSelectViewControllerDelegate.h"

@interface TypeSelectViewController : GeneralViewController

@property (nonatomic, weak) id<TypeSelectViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<TypeSelectViewControllerDelegate>) delegate;

@end
