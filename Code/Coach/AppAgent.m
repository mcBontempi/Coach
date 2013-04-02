#import "AppAgent.h"
#import "ProfileViewController.h"
#import "StackedProfileViewController.h"
#import "Coach.h"
#import "ModelProtocol.h"
#import "Model.h"
#import "Config.h"
#import "ConfigAgent.h"
#import "ViewerAgent.h"

@interface AppAgent () <ConfigAgentDelegate, ViewerAgentDelegate>

@property (nonatomic, strong) ConfigAgent *configAgent;
@property (nonatomic, strong) ViewerAgent *viewerAgent;
@property (nonatomic, strong) id<ModelProtocol> modelProtocol;

@end

@implementation AppAgent

-(id) init{
  self = [super init];
  if(self){
    self.modelProtocol = [[Model alloc] init];
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
  
  if(self.viewerAgent){
    [self.viewerAgent finish];
  }
  
  self.viewerAgent = [[ViewerAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self];
  self.viewerAgent.rootViewController = self.rootViewController;
  [self.viewerAgent start];
}

-(void) start{
   [self startViewer];
}

-(void) handleOpenURL:(NSURL *)url{

  NSData *data = [NSData dataWithContentsOfURL:url];

  [self.modelProtocol createPlanFromJSONDataAndMakeCurrent:data named:[[url path] lastPathComponent]];

  [self startViewer];
}

-(void) ConfigAgentDelegate_finished{
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

  [self.modelProtocol clearPlan];
  
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
    [self.modelProtocol setWeek:week array:[coach getWeekUsesProfileWithWeek:week]];
  }
}


-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  
}

@end
