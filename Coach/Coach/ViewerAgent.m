#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "TimetableViewController.h"
#import "Model.h"

@interface ViewerAgent () 

@property (nonatomic, strong) UINavigationController *viewerNavigationController;

@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;

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
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModel:self.model delegate:self.model];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;

    self.viewerNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.viewerNavigationController animated:YES];
}

@end
