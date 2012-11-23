#import <Foundation/Foundation.h>
#import "Config.h"

@protocol ConfigAgentDelegate <NSObject>

-(void) ConfigAgentDelegate_finished;

-(void) ConfigAgentDelegate_cancelled;

-(void) ConfigAgentDelegate_makePlan:(Config*) config;

@end
