#import "CHSlideController.h"

@interface SlideController : CHSlideController

- (id)initWithLeftViewController:(UIViewController*) leftViewController middleViewController:(UIViewController*) middleViewController ;

@property (nonatomic, strong) UIViewController *middleViewController;

-(void)bringInMiddleViewController;

@end
