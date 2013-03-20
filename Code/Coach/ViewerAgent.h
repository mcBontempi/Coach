#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "ListViewAgentDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ViewerAgentDelegate.h"
#import "UtilAgentDelegate.h"
#import "SlotEditViewAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate, TimetableViewAgentDelegate, UtilAgentDelegate, SlotEditViewAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<ViewerAgentDelegate>)delegate;
- (void)start;
- (void)finish;

@end
