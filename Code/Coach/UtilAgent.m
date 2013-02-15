#import "UtilAgent.h"
#import "UtilViewController.h"
#import "UtilAgentDelegate.h"
#import "Util.h"
#import "Config.h"
#import "PlanDetailAgent.h"
#import "PlanDetailViewController.h"

@interface UtilAgent () 
@property (nonatomic, strong) UINavigationController *wizardNavigationController;
@property (nonatomic, weak) id<UtilAgentDelegate> delegate;
@property (nonatomic, strong) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) PlanDetailAgent *planDetailAgent;

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

-(void) UtilViewControllerDelegate_makeEmptyPlanNamed:text numWeeks:(NSUInteger)numWeeks{
  [self.delegate UtilAgentDelegate_makeEmptyPlanNamed:text numWeeks:numWeeks];
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

-(void) UtilViewControllerDelegate_exportPlan:(NSString *)planName{
  
  if ([MFMailComposeViewController canSendMail]) {
    [self sendEmailWithAttachmentData: [self.modelDelegate getJSONForPlan:planName]];
  } else {
    [[[UIAlertView alloc] initWithTitle:@"Cannot send mail" message:@"You need to setup email in device settings" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
  }
}

-(NSUInteger) UtilViewControllerDelegate_numberOfPlans{
  return [self.modelDelegate planCount];
}

-(NSString *) UtilViewControllerDelegate_getPlanName:(NSUInteger)index{
  return [self.modelDelegate planName:index];
}

-(void) UtilViewControllerDelegate_deletePlan:(NSString *)planName{
  [self.modelDelegate deletePlan:planName];
}

-(void) UtilViewControllerDelegate_selectPlan:(NSString *)planName{
  [self.modelDelegate selectPlan:planName];
   [self close];
}

-(void) UtilViewControllerDelegate_showPlan:(NSString *)planName{

  self.planDetailAgent = [[PlanDetailAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self planName:planName];
  self.planDetailAgent.rootViewController = self.rootViewController;
  
  PlanDetailViewController *vc = [[PlanDetailViewController alloc] initWithDelegate:self.planDetailAgent];
 
  [self.wizardNavigationController pushViewController:vc animated:YES];

}

-(void) PlanDetailAgentDelegate_dataChanged{
  
}

-(void) PlanDetailAgentDelegate_close{
   [self.wizardNavigationController popToRootViewControllerAnimated:YES];
}


@end
