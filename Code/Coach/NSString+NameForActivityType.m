#import "NSString+NameForActivityType.h"

@implementation NSString (NameForActivityType)

+(NSString*) nameForActivityType:(TActivityType)activityType
{
  return @[@"Swim", @"Bike", @"Run", @"Strength and condictioning",
            @"8 Stack Multi Station",
           @"Leg Extension",
           @"Abdominal Crunch Bench",
           @"Leg Press",
            @"Abdominal",
           @"Medicine Ball",
            @"Adjustable Bench",
           @"Multi Adjustable Bench"
           ][activityType];
}

@end
