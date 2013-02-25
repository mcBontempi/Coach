#import <Foundation/Foundation.h>
#import "PlanDetailAgentDelegate.h"
#import "ModelProtocol.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PlanDetailViewControllerDelegate.h"

@interface PlanDetailAgent  : NSObject <MFMailComposeViewControllerDelegate, PlanDetailViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelDelegate delegate:(id<PlanDetailAgentDelegate>)delegate planName:(NSString *)planName;

@end
