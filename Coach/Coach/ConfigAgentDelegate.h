#import <Foundation/Foundation.h>
#import "Config.h"

@protocol ConfigAgentDelegate <NSObject>

-(void) ConfigAgentDelegate_finished;

-(void) makePlan:(Config*) config;

@end
