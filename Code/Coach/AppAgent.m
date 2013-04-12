#import "AppAgent.h"
#import "Coach.h"
#import "ModelProtocol.h"
#import "Model.h"
#import "Config.h"
#import "ViewerAgent.h"
#import "WelcomeViewController.h"

@interface AppAgent () <ViewerAgentDelegate, WelcomeViewControllerDelegate>

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

-(void) startViewer{
  
  if(self.viewerAgent){
    [self.viewerAgent finish];
  }
  
  self.viewerAgent = [[ViewerAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self];
  self.viewerAgent.rootViewController = self.rootViewController;
  [self.viewerAgent start];
}

-(void) start{

 
  
  WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithDelegate:self];
  
  
  [self.rootViewController  presentViewController:welcomeViewController animated:NO completion:nil];

}

- (void)WelcomeViewControllerDelegate_getStartedPressed
{
  
  [self.rootViewController dismissViewControllerAnimated:YES completion:^{ [self startViewer];}];
  
 
}

-(void) WelcomeViewControllerDelegate_cancelPressed
{
}


-(void) handleOpenURL:(NSURL *)url{

  NSData *data = [NSData dataWithContentsOfURL:url];

  [self.modelProtocol createPlanFromJSONDataAndMakeCurrent:data named:[[[url path] lastPathComponent] stringByDeletingPathExtension]];

  // For error information
  NSError *error;
  
  // Create file manager
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  [fileMgr removeItemAtURL:url error:&error];

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

-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  
}

@end
