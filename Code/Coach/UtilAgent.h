#import <Foundation/Foundation.h>

#import "UtilAgentDelegate.h"

@interface UtilAgent  : NSObject 

@property (nonatomic, strong) UIViewController *rootViewController;

-(void) startWithDelegate:(id<UtilAgentDelegate>) delegate;

@end
