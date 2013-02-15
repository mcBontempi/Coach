#import <Foundation/Foundation.h>
#import "PlanDetailAgentDelegate.h"
#import "ModelDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "PlanDetailViewControllerDelegate.h"

@interface PlanDetailAgent  : NSObject <MFMailComposeViewControllerDelegate, PlanDetailViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<PlanDetailAgentDelegate>) delegate planName:(NSString *) planName;

@end
