#import <Foundation/Foundation.h>
#import "ModelProtocol.h"
#import "ListViewAgentDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ViewerAgentDelegate.h"
#import "UtilAgentDelegate.h"
#import "SlotEditViewAgentDelegate.h"
#import "WelcomeViewController.h"
#import "IIViewDeckController.h"

@interface ViewerAgent : NSObject <IIViewDeckControllerDelegate, ListViewAgentDelegate, TimetableViewAgentDelegate, UtilAgentDelegate, SlotEditViewAgentDelegate, WelcomeViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<ViewerAgentDelegate>)delegate;
- (void)startShowWelcome:(BOOL)showWelcome;
- (void)finish;

@end
