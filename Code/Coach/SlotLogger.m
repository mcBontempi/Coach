#import "SlotLogger.h"

@implementation SlotLogger

+(void) logSlot:(Slot *)slot{
    
    NSString *activityName = @"";
    
    switch (slot.activityType){
        case EActivityTypeBike: activityName = @"Bike";break;
        case EActivityTypeRun: activityName = @"Run";break;
        case EActivityTypeSwim: activityName = @"Swim";break;
        case EActivityTypeStrengthAndConditioning: activityName = @"StrengthAndConditioning";break;
        case EActivityType8_stack_multi_station_small: activityName = @"8 Stack Multi Station";break;
        case EActivityTypeleg_extension_small: activityName = @"Leg Extension";break;
        case EActivityTypeabdominal_crunch_bench_small: activityName = @"Abdominal Crunch Bench";break;
        case EActivityTypeleg_press_small: activityName = @"Leg Press";break;
        case EActivityTypeabdominal_small: activityName = @"Abdominal";break;
        case EActivityTypemedicine_ball_small: activityName = @"Medicine Ball";break;
        case EActivityTypeadjustable_bench_small: activityName = @"Adjustable Bench";break;
        case EActivityTypemulti_adjustable_bench_small: activityName = @"Multi Adjustable Bench";break;
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
