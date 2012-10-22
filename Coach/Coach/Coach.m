#import "Coach.h"
#import "Slot.h"

@implementation Coach

// returns an array of slots, the slots are the day
-(NSArray*) getWeekUsesProfileWithWeek:(NSInteger) week{
    
    return nil;
}


// this gets a week, basically what sessions he needs to do within 1 week.
-(NSArray*) getStackedWeekUsesProfileWithWeek:(NSInteger) week{

    double weekPercentage = [[self.profile.array objectAtIndex:week-1] doubleValue];
    
    double totalHours = self.peakMinutes * weekPercentage/100;
 
    Slot *longRun = [[Slot alloc] initWithDuration:totalHours*0.20 activityType:EActivityTypeRun];
    Slot *tempoRun= [[Slot alloc] initWithDuration:totalHours*0.10 activityType:EActivityTypeRun];
    Slot *shortRun= [[Slot alloc] initWithDuration:totalHours*0.05 activityType:EActivityTypeRun];
    
    Slot *longBike = [[Slot alloc] initWithDuration:totalHours*0.30 activityType:EActivityTypeBike];
    Slot *shortBike = [[Slot alloc] initWithDuration:totalHours*0.10 activityType:EActivityTypeBike];
    
    Slot *swim1 = [[Slot alloc] initWithDuration:totalHours*0.10 activityType:EActivityTypeSwim];
    Slot *swim2 = [[Slot alloc] initWithDuration:totalHours*0.10 activityType:EActivityTypeSwim];
    Slot *swim3 = [[Slot alloc] initWithDuration:totalHours*0.05 activityType:EActivityTypeSwim];
    
    return [[NSArray alloc] initWithObjects:longRun, tempoRun, shortRun, longBike, shortBike, swim1, swim2, swim3, nil];
    
}

@end
