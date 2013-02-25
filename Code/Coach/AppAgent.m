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
#import "ViewerAgentDelegate.h"

@interface AppAgent () <ConfigAgentDelegate, ViewerAgentDelegate>

@property (nonatomic, strong) ConfigAgent *configAgent;
@property (nonatomic, strong) ViewerAgent *viewerAgent;
@property (nonatomic, strong) id<ModelDelegate> modelDelegate;

@end

@implementation AppAgent

-(id) init{
  self = [super init];
  if(self){
    self.modelDelegate = [[Model alloc] init];
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
  self.viewerAgent = [[ViewerAgent alloc] initWithModelDelegate:self.modelDelegate delegate:self];
  self.viewerAgent.rootViewController = self.rootViewController;
  [self.viewerAgent start];
}

-(void) start{
 // if(self.model)
 // {
  //  [self.model makeTestData];
 //   [self startViewer];
 // }
//  else{
   // [self startUtilWizard];
   [self startViewer];
//  }
}

-(void) handleOpenURL:(NSURL *)url{
  
  NSData *data = [NSData dataWithContentsOfURL:url];
  
  [self.modelDelegate createPlanFromJSONDataAndMakeCurrent:data];
  
  [self startViewer];
}

-(void) ConfigAgentDelegate_finished{
  
  //  [self.model ]
  [self startViewer];
}

-(void) ConfigAgentDelegate_cancelled{
  
  [self startViewer];
}

-(void) ViewerAgentDelegate_finished{
//  [self startUtilWizard];
}

-(void) UtilAgentDelegate_finished{
  //  [self.model ]
  [self startViewer];
}

-(void) UtilAgentDelegate_cancelled{
  
  [self startViewer];
}

-(void) ConfigAgentDelegate_makePlan:(Config*) config{
  
  [self.modelDelegate clearPlan];
  
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
  
  for(NSInteger week = 0 ; week < length ; week++){
    [self.modelDelegate setWeek:week array:[coach getWeekUsesProfileWithWeek:week]];
  }
}


-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  
}

@end
