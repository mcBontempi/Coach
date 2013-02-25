#import <Foundation/Foundation.h>
#import "ModelProtocol.h"

@interface Model : NSObject <ModelProtocol>

@property (nonatomic, strong, readonly) NSString *currentPlan;

@end
