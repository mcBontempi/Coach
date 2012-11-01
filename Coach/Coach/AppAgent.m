#import "AppAgent.h"
#import "ProfileViewController.h"
#import "StackedProfileViewController.h"
#import "Profile.h"
#import "Coach.h"
#import "Model.h"
#import "Config.h"
#import "ConfigAgent.h"
#import "ViewerAgent.h"
#import "ListAgent.h"

@interface AppAgent () <ConfigAgentDelegate>

@property (nonatomic, strong) ConfigAgent *configAgent;
@property (nonatomic, strong) ViewerAgent *viewerAgent;
@property (nonatomic, strong) ListAgent *listAgent;

@property (nonatomic, strong) Model *model;

@end

@implementation AppAgent

-(id) init{
    self = [super init];
    if(self){
        self.model = [[Model alloc] init];
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


-(void) startList{
    
    self.listAgent = [[ViewerAgent alloc] initWithModel:self.model];
    self.listAgent.rootViewController = self.rootViewController;
    
    [self.listAgent start];
}


-(void) start{
    
  //  [self startConfigWizard];
    
 //   [self startViewer];

    [self startList];
    
}

-(void) ConfigAgentDelegate_finished{
    [self startViewer];
}

-(void) makePlan:(Config*) config{
    
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
    
    self.model.weeks = [[NSMutableArray alloc] init];
    for(NSInteger week = 1 ; week <= length ; week++){
        [self.model.weeks addObject: [coach getWeekUsesProfileWithWeek:1]];
    }
    
}





@end
