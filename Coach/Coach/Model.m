#import "Model.h"
#import "Profile.h"
#import "Coach.h"

@implementation Model


-(id) init{
    self = [super init];
    if(self){
        
        Coach *coach = [[Coach alloc] init];
        
        // test data
        const NSInteger length = 45;
        
        Profile *profile = [[Profile alloc] init];
        profile.numberOfWeeks = length;
        profile.startPercentage =30;
        [profile generate];
        
        coach.profile = profile;
        coach.peakMinutes = 20*60;
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for(NSInteger week = 1 ; week <= length ; week++){
            [array addObject: [coach getWeekUsesProfileWithWeek:1]];
        }
        
        self.weeks = [NSArray arrayWithArray:array];
    }
    return self;
}
@end
