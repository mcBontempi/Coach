#import <UIKit/UIKit.h>
#import "AppAgent.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, strong) AppAgent *appAgent;

@end
