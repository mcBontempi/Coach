#import "UtilAgent.h"
#import "UtilViewController.h"
#import "UtilAgentDelegate.h"
#import "Util.h"
#import "Config.h"
#import "PlanDetailAgent.h"
#import "PlanDetailViewController.h"

@interface UtilAgent ()
@property (nonatomic, weak) id<UtilAgentDelegate> delegate;
@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, strong) PlanDetailAgent *planDetailAgent;
@end

@implementation UtilAgent

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<UtilAgentDelegate>)delegate
{
  if(self = [super init]){
    self.delegate = delegate;
    self.modelProtocol = modelProtocol;
  }
  return self;
}

-(void) sendEmailWithAttachmentData:(NSData *)attachmentData named:(NSString *)named
{
  MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
  controller.mailComposeDelegate = self;
  [controller setSubject:@"My Subject"];
  [controller setMessageBody:@"your training plan exported from TriathlonTimetable" isHTML:NO];
  [controller addAttachmentData:attachmentData mimeType:@"application/triathlontimetable" fileName:[NSString stringWithFormat:@"%@.ttt", named ]];
  if (controller){
    [self.rootViewController presentViewController:controller animated:YES completion:nil];
  }
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

#pragma -- mark UtilViewControllerDelegate methods

- (void)UtilViewControllerDelegate_askUserForNewPlanDetails
{
  DurationViewController *durationViewController = [[DurationViewController alloc] initWithDelegate:self];
  
  [self.rootViewController presentViewController:durationViewController animated:YES completion:^{  }];
}

- (void)UtilViewControllerDelegate_exportPlan:(NSString *)planName
{
  if ([MFMailComposeViewController canSendMail]) {
    [self sendEmailWithAttachmentData: [self.modelProtocol getJSONForPlan:planName] named:planName];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Cannot send mail" message:@"You need to setup email in device settings" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
  }
}

- (NSUInteger)UtilViewControllerDelegate_numberOfPlans
{
  return [self.modelProtocol planCount];
}

- (NSString *)UtilViewControllerDelegate_getPlanName:(NSUInteger)index
{
  return [self.modelProtocol planName:index];
}

- (void)UtilViewControllerDelegate_deletePlan:(NSString *)planName
{
  [self.modelProtocol deletePlan:planName];
}

- (void)UtilViewControllerDelegate_selectPlan:(NSString *)planName
{
  [self.modelProtocol selectPlan:planName];
}

- (void)UtilViewControllerDelegate_showPlan:(NSString *)planName
{
  [self.delegate UtilAgentDelegate_showPlan:planName];
}

- (NSString *)UtilViewControllerDelegate_currentPlan{
  return [self.modelProtocol currentPlan];
}


#pragma mark -- PlanDetailAgentDelegate

-(void) PlanDetailAgentDelegate_dataChanged{
}

-(void) PlanDetailAgentDelegate_close{
 // [self.rootViewController popToRootViewControllerAnimated:YES];
}

-(void) DurationViewControllerDelegate_finishedWith:(NSInteger) duration name:(NSString *)name
{
   [self.delegate UtilAgentDelegate_makeEmptyPlanNamed:name numWeeks:duration];
  [self.viewControllerProtocol UtilViewControllerProtocol_reloadData];
}



@end
