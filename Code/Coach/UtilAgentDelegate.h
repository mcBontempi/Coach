#import <Foundation/Foundation.h>
#import "Util.h"

@protocol UtilAgentDelegate <NSObject>

-(void) UtilAgentDelegate_finished;

-(void) UtilAgentDelegate_cancelled;

-(void) UtilAgentDelegate_makeEmptyPlan:(NSUInteger) duration;

@end
