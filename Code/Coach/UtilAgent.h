#import <Foundation/Foundation.h>
#import "UtilAgentDelegate.h"
#import "ModelProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PlanDetailAgentDelegate.h"
#import "UtilViewControllerDelegate.h"
#import "UtilViewControllerProtocol.h"

@interface UtilAgent  : NSObject <MFMailComposeViewControllerDelegate, PlanDetailAgentDelegate, UtilViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, weak) id<UtilViewControllerProtocol> viewControllerProtocol;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<UtilAgentDelegate>)delegate;

@end
