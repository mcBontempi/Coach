#import <Foundation/Foundation.h>
#import "Util.h"

@protocol UtilAgentDelegate <NSObject>

-(void) UtilAgentDelegate_finished;

-(void) UtilAgentDelegate_cancelled;

-(void) UtilAgentDelegate_makeEmptyPlanNamed:(NSString *)text numWeeks:(NSUInteger) duration;

@end
