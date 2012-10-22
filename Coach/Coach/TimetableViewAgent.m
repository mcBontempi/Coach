#import "TimetableViewAgent.h"
#import "Profile.h"
#import "Coach.h"

@interface TimetableViewAgent ()

@property (nonatomic, strong) NSArray *days;

@end

@implementation TimetableViewAgent

-(id) init{
    self = [super init];
    if(self) {
        
        
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
           [array addObject: [coach getStackedWeekUsesProfileWithWeek:1]];
      }

        self.days = [NSArray arrayWithArray:array];
        
    }
    
    return self;
}

@end
