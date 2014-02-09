#import "NSString+NameForActivityType.h"

@implementation NSString (NameForActivityType)

+(NSString*) nameForActivityType:(TActivityType)activityType
{
  return @[@"Swim", @"Bike", @"Run", @"Strength and condictioning", @"Cross Trainer"][activityType];
}

@end
