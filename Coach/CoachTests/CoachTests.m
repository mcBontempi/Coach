#import "CoachTests.h"
#import "Coach.h"
#import "SlotLogger.h"
#import "Profile.h"
#import "ProfileLogger.h"
#import "DataUtil.h"

@interface CoachTests ()

@property (nonatomic, retain) Coach *coach;

@end

@implementation CoachTests

- (void)setUp
{
    [super setUp];
    
    
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    [ProfileLogger logProfile:profile];
    
    self.coach = [[Coach alloc] init];
    
    self.coach.profile = profile;
    self.coach.peakMinutes = 20*60;
    
}

- (void)tearDown
{
    [super tearDown];
}




-(void) testGetDaysUsesProfile{
    
    
    for(NSInteger week = 1 ; week <=  self.coach.profile.array.count ; week++){
        NSArray *days = [self.coach getWeekUsesProfileWithWeek:week];

        NSInteger weekday = 0;
        for(NSArray *day in days){
            
            DLog(@"%@", [DataUtil weekdayFromWeekdayOrdinal:weekday++]);
            
            [SlotLogger logSlots:day];
        }
        
    }
}



- (void)testGetStackedWeeksUsesProfile{
   
    for(NSInteger week = 1 ; week <=  self.coach.profile.array.count ; week++){
        NSArray *slots = [self.coach getStackedWeekUsesProfileWithWeek:week];
        [SlotLogger logSlots:slots];
    }
    
}

@end
