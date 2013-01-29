#import <Foundation/Foundation.h>

#import "ConfigAgentDelegate.h"

@interface ConfigAgent  : NSObject 

@property (nonatomic, strong) UIViewController *rootViewController;

-(void) startWithDelegate:(id<ConfigAgentDelegate>) delegate;

@end
