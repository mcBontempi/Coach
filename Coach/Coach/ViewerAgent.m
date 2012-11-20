#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "ListViewAgent.h"
#import "TimetableViewController.h"
#import "ListViewController.h"
#import "Model.h"

#import "SlideController.h"


@interface ViewerAgent () 

@property (nonatomic, strong) UINavigationController *viewerNavigationController;
@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;
@property (nonatomic, strong) ListViewAgent *listViewAgent;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;

@property (nonatomic, strong) SlideController *slideController;

@end

@implementation ViewerAgent


-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate{
    self = [super init];
    if(self){
        self.modelDelegate = modelDelegate;
    }
    
    return self;
}

-(void) start{
   
    self.listViewAgent = [[ListViewAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self];
    ListViewController *listViewController = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
    self.listViewAgent.toListViewControllerDelegate = listViewController;
    
    
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate weekIndex:0];
    TimetableViewController *timetableViewController = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = timetableViewController;
    
    
    self.slideController = [[SlideController alloc] initWithLeftViewController:listViewController middleViewController:timetableViewController];
    
     [self.rootViewController presentModalViewController:self.slideController animated:YES];
}

-(void) showThisWeek{
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate weekIndex:0];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;
 
    [self.viewerNavigationController pushViewController:vc animated:YES];
}

-(void) showWeek:(NSInteger) weekIndex{
    [self.timetableViewAgent changeCurrentWeekAnimatedTo:weekIndex];
    
    [self.slideController bringInMiddleViewController];
}

-(void) ListViewAgentDelegate_showThisWeek{
    [self showThisWeek];
}

-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex{
    [self showWeek:weekIndex];
    
    
    
}


@end
