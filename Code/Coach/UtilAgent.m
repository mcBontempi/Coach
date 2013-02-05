#import "UtilAgent.h"
#import "UtilViewController.h"
#import "UtilAgentDelegate.h"
#import "Util.h"
#import "Config.h"

@interface UtilAgent () <UtilViewControllerDelegate>
@property (nonatomic, strong) UINavigationController *wizardNavigationController;
@property (nonatomic, weak) id<UtilAgentDelegate> delegate;
@end

@implementation UtilAgent

-(void) startWithDelegate:(id<UtilAgentDelegate>) delegate{
    self.delegate = delegate;
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


-(void) UtilViewControllerDelegate_export{


}

-(void) UtilViewControllerDelegate_makeEmptyPlan:(NSInteger)numWeeks{
  [self.delegate UtilAgentDelegate_makeEmptyPlan:5];
  [self close];
}

-(void) UtilViewControllerDelegate_cancel{
  [self close];
}


@end
