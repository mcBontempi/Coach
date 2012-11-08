#import "Model.h"
#import "Profile.h"
#import "Coach.h"

@interface Model ()

@property (nonatomic, strong) NSMutableArray* weeks;

@end

@implementation Model

-(void) makeTestData{
    Coach *coach = [[Coach alloc] init];
    
    // test data
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    coach.profile = profile;
    coach.peakMinutes = 20*60;
    
   self.weeks = [[NSMutableArray alloc] init];
    
    for(NSInteger week = 0 ; week <= length ; week++){
        [self.weeks addObject: [coach getWeekUsesProfileWithWeek:0]];
    }
}

-(NSArray*) getWeek:(NSInteger) weekIndex{
    NSArray *array = self.weeks[weekIndex];
    
    NSLog(@"%@", array.description);
    
    return self.weeks[weekIndex];
}

-(void) setWeek:(NSInteger) weekIndex array:(NSArray*) array{
    
    self.weeks[weekIndex] = array;
    
    //[self.weeks removeObjectAtIndex:weekIndex];
    //[self.weeks insertObject:array atIndex:weekIndex];
}


@end
