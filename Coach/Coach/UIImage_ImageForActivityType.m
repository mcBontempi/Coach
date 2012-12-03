
@implementation UIImage (ImageForActivityType)

+(UIImage *)imageForActivityType:(TActivityType)activityType{
   return [UIImage imageNamed:@[@"swim.png", @"bike.png", @"run.png", @"strengthandconditioning.png"][activityType]];
}
@end
