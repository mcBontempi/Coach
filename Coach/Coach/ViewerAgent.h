#import <Foundation/Foundation.h>
#import "ModelDelegate.h"
#import "ListViewAgentDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ViewerAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate, TimetableViewAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ViewerAgentDelegate>) delegate;
-(void) start;

@end
