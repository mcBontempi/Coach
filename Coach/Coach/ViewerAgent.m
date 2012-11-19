#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "ListViewAgent.h"
#import "TimetableViewController.h"
#import "ListViewController.h"
#import "Model.h"

@interface ViewerAgent () 

@property (nonatomic, strong) UINavigationController *viewerNavigationController;
@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;
@property (nonatomic, strong) ListViewAgent *listViewAgent;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;

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
    ListViewController *vc = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
    self.listViewAgent.toListViewControllerDelegate = vc;
    
    self.viewerNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.viewerNavigationController animated:YES];
    
    // test
    [self showThisWeek];
}

-(void) showThisWeek{
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate weekIndex:0];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;
 
    [self.viewerNavigationController pushViewController:vc animated:YES];
}

-(void) showWeek:(NSInteger) weekIndex{
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate weekIndex:(NSInteger) weekIndex];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;
    
    [self.viewerNavigationController pushViewController:vc animated:YES];
}

-(void) ListViewAgentDelegate_showThisWeek{
    [self showThisWeek];
}

-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex{
    [self showWeek:weekIndex];
}


@end
