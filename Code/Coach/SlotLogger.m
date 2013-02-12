#import "SlotLogger.h"

@implementation SlotLogger

+(void) logSlot:(Slot *)slot{
    
    NSString *activityName = @"";
    
    switch (slot.activityType){
        case EActivityTypeBike: activityName = @"Bike";break;
        case EActivityTypeRun: activityName = @"Run";break;
        case EActivityTypeSwim: activityName = @"Swim";break;
        case EActivityTypeStrengthAndConditioning: activityName = @"StrengthAndConditioning";break;
        case EActivityTypeBrick: activityName = @"Brick";break;
            
    }
    
    DLog(@"activityType = %@ \tduration = %d",activityName, slot.duration)
}

+(void) logSlots:(NSArray *)slots{
    
    DLog(@"-- Slots Start --");
  
    NSInteger totalDuration = 0;
    
    for(Slot *slot in slots){
        [SlotLogger logSlot:slot];
        totalDuration += slot.duration;
    }
    
    DLog(@"total duration in minutes  = %d", totalDuration);
    DLog(@"total duration in hours  = %d", totalDuration/60);

    DLog(@"-- Slots End --");

}

@end
