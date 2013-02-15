#import "PlanDetailViewController.h"

@implementation PlanDetailViewController

-(id) init{
  NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
  [exception raise];
  return nil;
}

-(id) initWithDelegate:(id<PlanDetailViewControllerDelegate>) delegate{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"PlanDetailViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"PlanDetailViewController_iPad" bundle:nil];
  }
  if(self){
    self.delegate = delegate;
    
  }
  
  return self;
}

- (IBAction)exportPressed:(id)sender {
  
  [self.delegate PlanDetailViewControllerDelegate_exportPlan];
}

- (IBAction)deletePressed:(id)sender {
  [self.delegate PlanDetailViewControllerDelegate_deletePlan];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.planNameLabel.text = [self.delegate PlanDetailViewControllerDelegate_planName];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return YES;
}

@end
