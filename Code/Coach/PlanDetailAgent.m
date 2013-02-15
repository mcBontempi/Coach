#import "PlanDetailAgent.h"
#import "PlanDetailViewController.h"
#import "PlanDetailAgentDelegate.h"
#import "Config.h"

@interface PlanDetailAgent ()
@property (nonatomic, weak) id<PlanDetailAgentDelegate> delegate;
@property (nonatomic, strong) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) NSString *planName;

@end

@implementation PlanDetailAgent


-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<PlanDetailAgentDelegate>) delegate planName:(NSString *) planName{
  self = [super init];
  if(self) {
    self.modelDelegate = modelDelegate;
    self.delegate = delegate;
    self.planName = planName;
  }
  return self;
}

-(void) sendEmailWithAttachmentData:(NSData *)attachmentData{
  MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  [controller setSubject:@"My Subject"];
  [controller setMessageBody:@"your training plan exported from TriathlonTimetable" isHTML:NO];
  [controller addAttachmentData:attachmentData mimeType:@"application/triathlontimetable" fileName:@"Plan.ttt"];
  if (controller) [self.rootViewController presentModalViewController:controller animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
  if (result == MFMailComposeResultSent) {
    NSLog(@"It's away!");
  }
  [self.rootViewController dismissModalViewControllerAnimated:YES];
}

-(void) PlanDetailViewControllerDelegate_exportPlan
{
  if ([MFMailComposeViewController canSendMail]) {
    [self sendEmailWithAttachmentData: [self.modelDelegate getJSONForPlan:self.planName]];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Cannot send mail" message:@"You need to setup email in device settings" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
  }
}

-(NSString *) PlanDetailViewControllerDelegate_planName{
  return self.planName;
}

-(void) PlanDetailViewControllerDelegate_deletePlan{
  [self.modelDelegate deletePlan:self.planName];
  [self.delegate PlanDetailAgentDelegate_close];
}

@end
