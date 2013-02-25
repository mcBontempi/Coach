#import <Foundation/Foundation.h>
#import "UtilAgentDelegate.h"
#import "ModelDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PlanDetailAgentDelegate.h"
#import "UtilViewControllerDelegate.h"

@interface UtilAgent  : NSObject <MFMailComposeViewControllerDelegate, PlanDetailAgentDelegate, UtilViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(void) startWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<UtilAgentDelegate>) delegate;
-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<UtilAgentDelegate>) delegate;

@end
