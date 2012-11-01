#import "ListAgent.h"
#import "TimetableViewAgent.h"
#import "TimetableViewController.h"
#import "Model.h"

@interface ListAgent () 

@property (nonatomic, strong) UINavigationController *listNavigationController;

@end

@implementation ListAgent


-(void) start{
    self.timetableViewAgent = [[TimetableViewAgent alloc] initWithModel:self.model delegate:self.model];
    TimetableV iewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.toTimetableViewControllerDelegate = vc;

    self.viewerNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.viewerNavigationController animated:YES];
}

@end
