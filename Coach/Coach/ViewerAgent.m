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

@property (nonatomic, strong) Model *model;

@end

@implementation ViewerAgent


-(id) initWithModel:(Model *) model{
    self = [super init];
    if(self){
        self.model = model;
    }
    
    return self;
}

-(void) start{
    self.listViewAgent = [[ListViewAgent alloc] initWithModel:self.model delegate:self];
    ListViewController *vc = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
    self.listViewAgent.toListViewControllerDelegate = vc;
    
    self.viewerNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.viewerNavigationController animated:YES];
    
       // test
    [self showThisWeek];
}

-(void) showThisWeek{
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.model];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;

 
    [self.viewerNavigationController pushViewController:vc animated:YES];
}

-(void) ListViewAgentDelegate_showThisWeek{
    [self showThisWeek];
}

@end
