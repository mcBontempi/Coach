#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "ListViewAgent.h"
#import "TimetableViewController.h"
#import "ListViewController.h"
#import "Model.h"
#import "IIViewDeckController.h"
#import "UtilViewController.h"
#import "UtilAgent.h"
#import "Coach.h"
#import "SlotEditViewController.h"
#import "SlotEditViewAgent.h"

@interface ViewerAgent ()

@property (nonatomic, strong) UtilAgent *utilAgent;
@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;
@property (nonatomic, strong) ListViewAgent *listViewAgent;
@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, strong) IIViewDeckController *viewDeckViewController;
@property (nonatomic, weak) id<ViewerAgentDelegate> delegate;

@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) TimetableViewController *timetableViewController;

@property (nonatomic, strong) SlotEditViewAgent *slotEditViewAgent;
@end

@implementation ViewerAgent

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<ViewerAgentDelegate>)delegate
{
  self = [super init];
  if(self){
    self.modelProtocol = modelProtocol;
    self.delegate = delegate;
  }
  
  return self;
}

-(void) startShowWelcome:(BOOL)showWelcome
{
  self.utilAgent = [[UtilAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self];
  UtilViewController *vc = [[UtilViewController alloc] initWithDelegate:self.utilAgent];
  self.utilAgent.viewControllerProtocol = vc;
  
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
  self.navigationController.navigationBarHidden = YES;
  
  self.utilAgent.rootViewController = vc;
  
  // Create the left hand side list
  self.listViewAgent = [[ListViewAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self];
  ListViewController *listViewController = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
  self.listViewAgent.toListViewControllerDelegate = listViewController;
  
  UINavigationController *listViewNavigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
  listViewNavigationController.navigationBar.tintColor = [UIColor blackColor];
  // Create the main Timetable view
  self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self weekIndex:0];
  self.timetableViewController = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
  self.timetableViewAgent.toTimetableViewControllerDelegate = self.timetableViewController;
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.timetableViewController];
  nc.navigationBar.tintColor = [UIColor darkGrayColor];
  
  // add the two views tot he view deck
  self.viewDeckViewController = [[IIViewDeckController alloc] initWithCenterViewController:nc leftViewController:listViewNavigationController];
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    self.viewDeckViewController.leftLedge = 60;
  else
    self.viewDeckViewController.leftLedge = 500;
  
  
  if([self.modelProtocol currentPlan].length){
    [self.rootViewController presentModalViewController:self.navigationController animated:NO];
    [self.navigationController pushViewController:self.viewDeckViewController animated:YES];
    if(showWelcome){
      WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithDelegate:self];
      [self.viewDeckViewController  presentViewController:welcomeViewController animated:NO completion:nil];
    }else{
      [self showInitialWeekAfterDelay];
    }
  }
  else{
    [self.rootViewController presentModalViewController:self.navigationController animated:NO];
    if(showWelcome){
      WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithDelegate:self];
      [self.navigationController  presentViewController:welcomeViewController animated:NO completion:nil];
    }
  }
}

- (void)WelcomeViewControllerDelegate_getStartedPressed
{
  if([self.modelProtocol currentPlan].length){
    
    [self showInitialWeekAfterDelay];
  }
}

-(void) WelcomeViewControllerDelegate_cancelPressed
{
}

-(void) finish{
  [self.rootViewController dismissViewControllerAnimated: NO completion: ^
   {
     [self.delegate ViewerAgentDelegate_finished];
   }];
}

-(void) showInitialWeekImmediately
{
  [self.timetableViewAgent changeCurrentWeekAnimatedTo:0];
  
  [self.listViewAgent highlightCurrentWeek:0];
  
  [self.viewDeckViewController openLeftViewAnimated:YES];
  
}

-(void) showInitialWeekAfterDelay{
  
  [self performSelector:@selector(showInitialWeekImmediately) withObject:nil afterDelay:0.001];
  
}


-(void) showWeek:(NSInteger) weekIndex{
  [self.timetableViewAgent changeCurrentWeekAnimatedTo:weekIndex];
  [self.viewDeckViewController closeLeftView];
}

-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex{
  [self showWeek:weekIndex];
}

-(void) ListViewAgentDelegate_showPlansInFullscreen{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void) ListViewAgentDelegate_selectPlanFromPopover:(NSString *)planName
{
  [self.modelProtocol selectPlan:planName];
  [self showInitialWeekImmediately];
  
}

-(void) TimetableViewAgentDelegate_editingModeChangedIsEditing:(BOOL) editing{
  
  if(editing) {
    self.viewDeckViewController.panningMode = IIViewDeckNoPanning;
  }
  else{
    
    self.viewDeckViewController.panningMode = IIViewDeckFullViewPanning;
  }
}

-(void) TimetableViewAgentDelegate_bookmarksPressed{
  [self.viewDeckViewController toggleLeftViewAnimated:YES];
}

- (void) TimetableViewAgentDelegate_showFullscreenEditorForSlot:(Slot *)slot
{
  
  self.slotEditViewAgent = [[SlotEditViewAgent alloc] initWitSlot:slot delegate:self];
  SlotEditViewController *slotEditViewController = [[SlotEditViewController alloc] initWithDelegate:self.slotEditViewAgent];
  
  [self.timetableViewController presentModalViewController:slotEditViewController animated:YES];
  
}

- (void) showPlan:(NSString *)planName
{
  [self.modelProtocol selectPlan:planName];
  
  [self.navigationController pushViewController:self.viewDeckViewController animated:YES];
  [self.viewDeckViewController toggleLeftViewAnimated:YES];
  [self showInitialWeekAfterDelay];
}

-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  [self showPlan:planName];
  
}

-(void) UtilAgentDelegate_makeEmptyPlanNamed:(NSString *)planName numWeeks:(NSUInteger) numWeeks{
  
  if([self.modelProtocol checkPlanNameIsAlreadyTaken:planName]){
    [[[UIAlertView alloc] initWithTitle:@"plan not imported" message:@"name already in use" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    
  }
  else{
    [self.modelProtocol makePlanNamed:planName];
    
    Coach *coach = [[Coach alloc] init];
    
    for(NSInteger week = 0 ; week < numWeeks ; week++){
      [self.modelProtocol setWeek:week array:[coach getEmptyWeek]];
    }
  }
  
  
}



@end
