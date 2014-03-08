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
           @"Multi Adjustable Bench",
           @"Adjustable Decline Bench",
           @"Multi Mode Rope Climber",
           @"Arm Curl",
           @"Olympic Bar",
           @"Ascent Trainer",
           @"Pectoral Fly",
           @"Back Extension",
           @"Power Station",
           @"Calf Press",
           @"Prone Leg Curl",
           @"Chest Press",
           @"Rear Delt Fly",
           @"Converging Chest Press",
           @"Recumbant Cycle",
           @"Converging Shoulder Press",
           @"Rotatry Hip",
           @"Dip Chin Assist",
           @"Rotary Torso",
           @"Diverging Lat Pulldown",
           @"Rower",
           @"Diverging Seated Row",
           @"Seated Dip",
           @"Dumbbells",
           @"Seated Leg Curl",
           @"Elliptical Trainer",
           @"Seated Row",
           @"Functional Trainer",
           @"Shoulder Press",
           @"Hip Abductor",
           @"Smith Machine",
           @"Hip Abductor",
           @"Spinner Bike",
           @"Hybrid Cycle",
           @"Stepper",
           @"Indoor Cycle",
           @"Treadmill",
           @"Kettleballs",
           @"Triceps Extension",
           @"Lat Pull",
           @"Upright Cycle"
           ][activityType];
}

@end
