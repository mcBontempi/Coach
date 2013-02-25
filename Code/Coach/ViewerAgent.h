#import <Foundation/Foundation.h>
#import "ModelDelegate.h"
#import "ListViewAgentDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ViewerAgentDelegate.h"
#import "UtilAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate, TimetableViewAgentDelegate, UtilAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ViewerAgentDelegate>) delegate;
-(void) start;

@end
