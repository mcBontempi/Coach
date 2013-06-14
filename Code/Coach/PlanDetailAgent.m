#import "PlanDetailAgent.h"
#import "PlanDetailViewController.h"
#import "PlanDetailAgentDelegate.h"
#import "Config.h"

@interface PlanDetailAgent ()
@property (nonatomic, weak) id<PlanDetailAgentDelegate> delegate;
@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, strong) NSString *planName;

@end

@implementation PlanDetailAgent


- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<PlanDetailAgentDelegate>)delegate planName:(NSString *) planName
{
  self = [super init];
  if(self) {
    self.modelProtocol = modelProtocol;
    self.delegate = delegate;
    self.planName = planName;
  }
  return self;
}

-(void) sendEmailWithAttachmentData:(NSData *)attachmentData
{
  MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  [controller setSubject:@"My Subject"];
  [controller setMessageBody:@"your training plan exported from TriathlonTimetable" isHTML:NO];
  [controller addAttachmentData:attachmentData mimeType:@"application/triathlontimetable" fileName:@"Plan.ttt"];
  if (controller) [self.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
  if (result == MFMailComposeResultSent) {
    NSLog(@"It's away!");
  }
  [self.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void) PlanDetailViewControllerDelegate_exportPlan
{
  if ([MFMailComposeViewController canSendMail]) {
    [self sendEmailWithAttachmentData: [self.modelProtocol getJSONForPlan:self.planName]];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Cannot send mail" message:@"You need to setup email in device settings" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
  }
}

-(NSString *) PlanDetailViewControllerDelegate_planName{
  return self.planName;
}

-(void) PlanDetailViewControllerDelegate_deletePlan{
  [self.modelProtocol deletePlan:self.planName];
  [self.delegate PlanDetailAgentDelegate_close];
}

@end
