#import "CHSlideController.h"

@interface DemoSlideControllerSubclass : CHSlideController

- (id)initWithLeftViewController:(UIViewController*) leftViewController middleViewController:(UIViewController*) middleViewController ;

@property (nonatomic, strong) UIViewController *middleViewController;

-(void)bringInMiddleViewController;

@end
