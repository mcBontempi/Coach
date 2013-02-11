#import <Foundation/Foundation.h>
#import "UtilAgentDelegate.h"
#import "ModelDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface UtilAgent  : NSObject <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(void) startWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<UtilAgentDelegate>) delegate;

@end
