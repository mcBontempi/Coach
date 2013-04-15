#import "AppAgent.h"
#import "Coach.h"
#import "ModelProtocol.h"
#import "Model.h"
#import "Config.h"
#import "ViewerAgent.h"

@interface AppAgent () <ViewerAgentDelegate>

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

-(void) startViewerShowWelcome:(BOOL)showWelcome{
  
  if(self.viewerAgent){
    [self.viewerAgent finish];
  }
  
  self.viewerAgent = [[ViewerAgent alloc] initWithModelProtocol:self.modelProtocol delegate:self];
  self.viewerAgent.rootViewController = self.rootViewController;
  [self.viewerAgent startShowWelcome:showWelcome];
}

-(void) start
{
  [self startViewerShowWelcome:YES];
}

-(void) handleOpenURL:(NSURL *)url{

  NSData *data = [NSData dataWithContentsOfURL:url];

  [self.modelProtocol createPlanFromJSONDataAndMakeCurrent:data named:[[[url path] lastPathComponent] stringByDeletingPathExtension]];

  // For error information
  NSError *error;
  
  // Create file manager
  NSFileManager *fileMgr = [NSFileManager defaultManager];
  
  [fileMgr removeItemAtURL:url error:&error];

  [self startViewerShowWelcome:NO];
}

-(void) ViewerAgentDelegate_finished{
//  [self startUtilWizard];
}

-(void) UtilAgentDelegate_finished{
  //  [self.model ]
  [self startViewerShowWelcome:NO];
}

-(void) UtilAgentDelegate_cancelled{

  [self startViewerShowWelcome:NO];
}

-(void) UtilAgentDelegate_showPlan:(NSString *)planName{
  
}

@end
