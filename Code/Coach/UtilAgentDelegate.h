#import <Foundation/Foundation.h>
#import "Util.h"

@protocol UtilAgentDelegate <NSObject>

-(void) UtilAgentDelegate_makeEmptyPlanNamed:(NSString *)text numWeeks:(NSUInteger) duration;

-(void) UtilAgentDelegate_showPlan:(NSString *)planName;

@end
