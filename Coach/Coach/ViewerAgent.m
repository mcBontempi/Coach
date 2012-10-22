#import "ViewerAgent.h"
#import "TimetableViewAgent.h"
#import "TimetableViewController.h"

@interface ViewerAgent () 

@property (nonatomic, strong) UINavigationController *viewerNavigationController;

@property (nonatomic, strong) TimetableViewAgent *timetableViewAgent;

@end

@implementation ViewerAgent

-(void) start{
    self.timetableViewAgent = [[TimetableViewAgent alloc] init];
    TimetableViewController *vc = [[TimetableViewController alloc] initWithDelegate:self.timetableViewAgent];
    self.timetableViewAgent.delegate = vc;

    self.viewerNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.viewerNavigationController animated:YES];
}

@end
