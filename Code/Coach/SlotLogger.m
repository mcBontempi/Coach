//
//  SlotLogger.m
//  Coach
//
//  Created by Daren Taylor on 19/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

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
    
    DLog(@"activityType = %@ \tstart = %d \tduration = %d",activityName, slot.start, slot.duration)
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