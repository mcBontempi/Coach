#import "ConfigAgent.h"
#import "WelcomeViewController.h"
#import "TypeSelectViewController.h"
#import "DurationViewController.h"

#import "WelcomeViewControllerDelegate.h"
#import "TypeSelectViewControllerDelegate.h"
#import "DurationViewControllerDelegate.h"

@interface ConfigAgent () <WelcomeViewControllerDelegate, TypeSelectViewControllerDelegate, DurationViewControllerDelegate>

@property (nonatomic, strong) UINavigationController *wizardNavigationController;

@end

@implementation ConfigAgent

-(void) start{
    WelcomeViewController *vc = [[WelcomeViewController alloc] initWithDelegate:self];
    self.wizardNavigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.rootViewController presentModalViewController:self.wizardNavigationController animated:YES];
}

-(void) WelcomeViewControllerDelegate_getStartedPressed{
    
    TypeSelectViewController *vc = [[TypeSelectViewController alloc] initWithDelegate:self];
    [self.wizardNavigationController pushViewController:vc animated:YES];
}


-(void) TypeSelectViewControllerDelegate_typePressed:(TType) type{
    DurationViewController *vc = [[DurationViewController alloc] initWithDelegate:self];
    [self.wizardNavigationController pushViewController:vc animated:YES];
    
}

-(void) DurationViewControllerDelegate_nextPressed:(NSInteger)duration{
    
    
    
}



@end
