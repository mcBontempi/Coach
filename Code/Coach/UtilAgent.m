#import "UtilAgent.h"
#import "UtilViewController.h"
#import "UtilAgentDelegate.h"
#import "Util.h"
#import "Config.h"

@interface UtilAgent () <UtilViewControllerDelegate>
@property (nonatomic, strong) UINavigationController *wizardNavigationController;
@property (nonatomic, weak) id<UtilAgentDelegate> delegate;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;

@end

@implementation UtilAgent

-(void) startWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<UtilAgentDelegate>) delegate{
    self.delegate = delegate;
    self.modelDelegate = modelDelegate;
    UtilViewController *vc = [[UtilViewController alloc] initWithDelegate:self];
    self.wizardNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.rootViewController presentModalViewController:self.wizardNavigationController animated:YES];
}


-(void) close{
  
  [self.rootViewController dismissViewControllerAnimated: YES completion: ^
   {
     [self.delegate UtilAgentDelegate_finished];
   }];
}

-(void) UtilViewControllerDelegate_makeEmptyPlan:(NSInteger)numWeeks{
  [self.delegate UtilAgentDelegate_makeEmptyPlan:5];
  [self close];
}

-(void) UtilViewControllerDelegate_cancel{
  [self close];
}


-(void) sendEmailWithAttachmentData:(NSData *)attachmentData{
  MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  [controller setSubject:@"My Subject"];
  [controller setMessageBody:@"your training plan exported from TriathlonTimetable" isHTML:NO];
  [controller addAttachmentData:attachmentData mimeType:@"application/triathlontimetable" fileName:@"Plan.ttt"];
  if (controller) [self.wizardNavigationController presentModalViewController:controller animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
  if (result == MFMailComposeResultSent) {
    NSLog(@"It's away!");
  }
  [self.wizardNavigationController dismissModalViewControllerAnimated:YES];
}

-(void) UtilViewControllerDelegate_export{
  
  if ([MFMailComposeViewController canSendMail]) {
    [self sendEmailWithAttachmentData: [self.modelDelegate getJSON]];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Cannot send mail" message:@"You need to setup email in device settings" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
  }
}


@end
