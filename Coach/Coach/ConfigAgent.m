#import "ConfigAgent.h"
#import "WelcomeViewController.h"
#import "TypeSelectViewController.h"
#import "DurationViewController.h"
#import "EffortViewController.h"
#import "FinishViewController.h"

#import "WelcomeViewControllerDelegate.h"
#import "TypeSelectViewControllerDelegate.h"
#import "DurationViewControllerDelegate.h"
#import "EffortViewControllerDelegate.h"
#import "FinishViewControllerDelegate.h"
#import "ToFinishViewControllerDelegate.h"

#import "Config.h"


@interface ConfigAgent () <WelcomeViewControllerDelegate, TypeSelectViewControllerDelegate, DurationViewControllerDelegate, EffortViewControllerDelegate, FinishViewControllerDelegate>

@property (nonatomic, strong) UINavigationController *wizardNavigationController;
@property (nonatomic, weak) id<ConfigAgentDelegate> delegate;

@property (nonatomic, weak) id<ToFinishViewControllerDelegate> toFinishViewControllerDelegate;

@property (nonatomic, strong) Config *config;

@end

@implementation ConfigAgent

-(void) startWithDelegate:(id<ConfigAgentDelegate>) delegate{
    
    self.config = [[Config alloc] init];
    self.delegate = delegate;
    WelcomeViewController *vc = [[WelcomeViewController alloc] initWithDelegate:self];
    self.wizardNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    
    [self.rootViewController presentModalViewController:self.wizardNavigationController animated:YES];
}

-(void) WelcomeViewControllerDelegate_getStartedPressed{
    
    TypeSelectViewController *vc = [[TypeSelectViewController alloc] initWithDelegate:self];
    [self.wizardNavigationController pushViewController:vc animated:YES];
}


-(void) TypeSelectViewControllerDelegate_typePressed:(TType) type{
    self.config.type = type;
    DurationViewController *vc = [[DurationViewController alloc] initWithDelegate:self];
    [self.wizardNavigationController pushViewController:vc animated:YES];
    
}

-(void) DurationViewControllerDelegate_nextPressed:(NSInteger)duration{
    self.config.duration = duration;
    EffortViewController *vc = [[EffortViewController alloc] initWithDelegate:self];
    [self.wizardNavigationController pushViewController:vc animated:YES];
}

-(void) EffortViewControllerDelegate_effortPressed:(TEffort)effort{
    self.config.effort = effort;
    FinishViewController *vc = [[FinishViewController alloc] initWithDelegate:self];
    self.toFinishViewControllerDelegate = vc;
    [self.wizardNavigationController pushViewController:vc animated:YES];
}

-(void) FinishViewControllerDelegate_makePlanPressed{
    
    [self.delegate ConfigAgentDelegate_makePlan:self.config];
    
    [self performSelector:@selector(planCreated) withObject:nil afterDelay:1.0];
        
}

-(void) planCreated{
    
    [self.toFinishViewControllerDelegate ToFinishViewControllerDelegate_planCreated];
}

-(void) FinishViewControllerDelegate_getStartedPressed{
    
    [self.rootViewController dismissViewControllerAnimated: YES completion: ^
     {
         [self.delegate ConfigAgentDelegate_finished];
     }];
}

@end
