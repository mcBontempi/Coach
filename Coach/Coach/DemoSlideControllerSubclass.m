#import "DemoSlideControllerSubclass.h"

@implementation DemoSlideControllerSubclass

- (id)initWithLeftViewController:(UIViewController*) leftViewController middleViewController:(UIViewController*) middleViewController
{
    self = [super init];
    if (self) {
        
        self.middleViewController = middleViewController;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:middleViewController];
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedLeftButton)];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedRightButton)];
        
        middleViewController.navigationItem.leftBarButtonItem = button;
        middleViewController.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
        middleViewController.navigationItem.rightBarButtonItem = rightButton;
        
        UIViewController *rightController = [[UIViewController alloc] init];
        rightController.view.backgroundColor = [UIColor darkGrayColor];
        
        self.leftStaticViewController = leftViewController;
        self.rightStaticViewController = rightController;
        self.slidingViewController = nav;
    }
    return self;
}

// Our subclass is responsible for handling events happening
// in static and sliding controller and for showing/hiding stuff

-(void)bringInMiddleViewController
{
    
    UIViewController *controller = self.middleViewController;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedLeftButton)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(pressedRightButton)];
    
    controller.navigationItem.rightBarButtonItem = rightButton;
    controller.navigationItem.leftBarButtonItem = button;
    controller.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    self.slidingViewController = nav;
    
    [self showSlidingViewAnimated:YES];
}

-(void)pressedLeftButton
{
    
    if (isLeftStaticViewVisible) {
        [self showSlidingViewAnimated:YES];
    }else {
        [self showLeftStaticView:YES];
    }
    
    
}

-(void)pressedRightButton
{
    NSLog(@"Pressed right button");
    
    if (isRightStaticViewVisible) {
        [self showSlidingViewAnimated:YES];
    }else {
        [self showRightStaticView:YES];
    }
}


@end
