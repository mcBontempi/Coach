#import <Foundation/Foundation.h>
#import "Profile.h"

@interface Coach : NSObject

-(NSArray *) getWeekUsesProfileWithWeek:(NSInteger) week;
-(NSArray*) getStackedWeekUsesProfileWithWeek:(NSInteger) week;

@property (nonatomic, strong) Profile *profile;
@property double peakMinutes;

@end