#import <Foundation/Foundation.h>
#import "TimetableViewAgentDelegate.h"


@interface Model : NSObject <TimetableViewAgentDelegate>

// structure is weeks / days / slots
@property (nonatomic, strong) NSMutableArray* weeks;

@end
