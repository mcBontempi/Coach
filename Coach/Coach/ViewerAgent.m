#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "ListViewAgent.h"
#import "TimetableViewController.h"
#import "ListViewController.h"
#import "Model.h"
#import "IIViewDeckController.h"

@interface ViewerAgent () 

@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;
@property (nonatomic, strong) ListViewAgent *listViewAgent;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) IIViewDeckController *viewDeckViewController;
@property (nonatomic, weak) id<ViewerAgentDelegate> delegate;
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
   
    self.listViewAgent = [[ListViewAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self];
    ListViewController *listViewController = [[ListViewController alloc] initWithDelegate:self.listViewAgent];
    self.listViewAgent.toListViewControllerDelegate = listViewController;
    
    
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self weekIndex:0];

    TimetableViewController *timetableViewController = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = timetableViewController;
    UINavigationController *timetableNavigationController = [[UINavigationController alloc] initWithRootViewController:timetableViewController];
    timetableNavigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    self.viewDeckViewController = [[IIViewDeckController alloc] initWithCenterViewController:timetableNavigationController leftViewController:listViewController];
    
    self.viewDeckViewController.leftLedge = 150;
    
    
    
     [self.rootViewController presentModalViewController:self.viewDeckViewController animated:YES];
    
    [self.viewDeckViewController bounceLeftView];
}

-(void) finish{
    [self.rootViewController dismissViewControllerAnimated: YES completion: ^
     {
         [self.delegate ViewerAgentDelegate_finished];
     }];
}


-(void) showWeek:(NSInteger) weekIndex{
    [self.timetableViewAgent changeCurrentWeekAnimatedTo:weekIndex];
    
    [self.viewDeckViewController closeLeftView];
}

-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex{
    [self showWeek:weekIndex];
}

-(void) ListViewAgentDelegate_newTimetable{
    [self finish];
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


@end
