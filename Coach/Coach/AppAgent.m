#import "AppAgent.h"
#import "ProfileViewController.h"
#import "StackedProfileViewController.h"
#import "Profile.h"
#import "Coach.h"
#import "ModelDelegate.h"
#import "Model.h"
#import "Config.h"
#import "ConfigAgent.h"
#import "ViewerAgent.h"

@interface AppAgent () <ConfigAgentDelegate>

@property (nonatomic, strong) ConfigAgent *configAgent;
@property (nonatomic, strong) ViewerAgent *viewerAgent;

@property (nonatomic, strong) Model *model;

@property (nonatomic, weak) id<ModelDelegate> modelDelegate;

@end

@implementation AppAgent

-(id) init{
    self = [super init];
    if(self){
        self.model = [[Model alloc] init];
    
        self.modelDelegate = self.model;
    }
    return self;
}

-(void) showProfileViewController{
    // test data
    
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    vc.profile = profile;
    [self.rootViewController presentModalViewController:vc animated:YES];
}


-(void) showStackedProfileViewController{
    // test data
    
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    Coach *coach = [[Coach alloc] init];
    coach.profile = profile;
    coach.peakMinutes = 20*60;
    
    NSArray *week = [coach getStackedWeekUsesProfileWithWeek:1];
    
    StackedProfileViewController *vc = [[StackedProfileViewController alloc] init];
    vc.slots = week;
    
    [self.rootViewController presentModalViewController:vc animated:YES];
}

-(void) startConfigWizard{
    self.configAgent = [[ConfigAgent alloc] init];
    self.configAgent.rootViewController = self.rootViewController;
    
    [self.configAgent startWithDelegate:self];
}

-(void) startViewer{
    self.viewerAgent = [[ViewerAgent alloc] initWithModel:self.model];
    self.viewerAgent.rootViewController = self.rootViewController;
    
    [self.viewerAgent start];
}

-(void) start{
//     [self startConfigWizard];

    [self.model makeTestData];
    
    [self startViewer];
}

-(void) ConfigAgentDelegate_finished{
    [self startViewer];
}

-(void) ConfigAgentDelegate_makePlan:(Config*) config{
    
    Coach *coach = [[Coach alloc] init];
    
    // test data
    const NSInteger length = config.duration;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    coach.profile = profile;
    
    switch(config.effort){
        case EEffortEasy: coach.peakMinutes = 5*60; break;
        case EEffortIntermediate: coach.peakMinutes = 10*60; break;
        case EEffortCompetitive: coach.peakMinutes = 20*60; break;
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for(NSInteger week = 0 ; week < length ; week++){
        [mutableArray addObject: [coach getWeekUsesProfileWithWeek:week]];
        [self.modelDelegate setWeek:week array:mutableArray];
    }
    

    
    
}





@end
