#import "CoachTests.h"
#import "Coach.h"
#import "SlotLogger.h"
#import "Profile.h"
#import "ProfileLogger.h"

@interface CoachTests ()

//@property (nonatomic, retain) Coach *coach;

@end

@implementation CoachTests

- (void)setUp
{
    [super setUp];
    
  //  self.coach = [[Coach alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testTestDataSet1WithProfile{
    /*
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    [ProfileLogger logProfile:profile];
  
    self.coach.profile = profile;
    self.coach.peakMinutes = 20*60;
    
    for(NSInteger week = 1 ; week <= length ; week++){
        NSArray *slots = [self.coach getStackedWeekUsesProfileWithWeek:week];
        [SlotLogger logSlots:slots];
    }
     */
}

@end
