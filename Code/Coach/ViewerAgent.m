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

@interface ViewerAgent ()

@property (nonatomic, strong) UtilAgent *utilAgent;
@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;
@property (nonatomic, strong) ListViewAgent *listViewAgent;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) IIViewDeckController *viewDeckViewController;
@property (nonatomic, weak) id<ViewerAgentDelegate> delegate;

@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation ViewerAgent


-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ViewerAgentDelegate>) delegate{
    self = [super init];
    if(self){
        self.modelDelegate = modelDelegate;
        self.delegate = delegate;
    }
    
    return self;
}

-(void) start{
  
  self.utilAgent = [[UtilAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self];
  UtilViewController *vc = [[UtilViewController alloc] initWithDelegate:self.utilAgent];
 
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
  self.navigationController.navigationBarHidden = YES;
  
    // Create the left hand side list
    self.listViewAgent = [[ListViewAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self];
    ListViewController *listViewController = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
    self.listViewAgent.toListViewControllerDelegate = listViewController;
  
  UINavigationController *listViewNavigationController = [[UINavigationController alloc] initWithRootViewController:listViewController];
//  listViewNavigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    // Create the main Timetable view
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self weekIndex:0];
    TimetableViewController *timetableViewController = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = timetableViewController;
    UINavigationController *timetableNavigationController = [[UINavigationController alloc] initWithRootViewController:timetableViewController];
    timetableNavigationController.navigationBar.tintColor = [UIColor darkGrayColor];
 
    // add the two views tot he view deck
    self.viewDeckViewController = [[IIViewDeckController alloc] initWithCenterViewController:timetableNavigationController leftViewController:listViewNavigationController];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        self.viewDeckViewController.leftLedge = 60;
    else
        self.viewDeckViewController.leftLedge = 500;
    
    [self.rootViewController presentModalViewController:self.navigationController animated:NO];
  
  [self.navigationController pushViewController:self.viewDeckViewController animated:YES];
  
  
  
    [self showInitialWeek];
}

-(void) finish{
    [self.rootViewController dismissViewControllerAnimated: YES completion: ^
     {
         [self.delegate ViewerAgentDelegate_finished];
     }];
}

-(void) showInitialWeek{
    
    [self.timetableViewAgent changeCurrentWeekAnimatedTo:0];
    
    [self.listViewAgent highlightCurrentWeek:0];
    
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


-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  
  [self.modelDelegate selectPlan:planName];
  
  [self.navigationController pushViewController:self.viewDeckViewController animated:YES];
  
}

-(void) UtilAgentDelegate_makeEmptyPlanNamed:(NSString *)planName numWeeks:(NSUInteger) numWeeks{
  
  [self.modelDelegate makePlanNamed:planName];
  
  Coach *coach = [[Coach alloc] init];
  
  for(NSInteger week = 0 ; week < numWeeks ; week++){
    [self.modelDelegate setWeek:week array:[coach getEmptyWeek]];
  }
}



@end
