#import <Foundation/Foundation.h>
#import "UtilAgentDelegate.h"
#import "ModelProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PlanDetailAgentDelegate.h"
#import "UtilViewControllerDelegate.h"
#import "UtilViewControllerProtocol.h"
#import "DurationViewController.h"

@interface UtilAgent  : NSObject <MFMailComposeViewControllerDelegate, PlanDetailAgentDelegate, UtilViewControllerDelegate, DurationViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, weak) id<UtilViewControllerProtocol> viewControllerProtocol;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<UtilAgentDelegate>)delegate;

@end
