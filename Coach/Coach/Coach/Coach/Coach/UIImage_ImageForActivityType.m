
@implementation UIImage (ImageForActivityType)

+(UIImage *)imageForActivityType:(TActivityType)activityType{
   return [UIImage imageNamed:[NSArray arrayWithObjects:@"swim.png", @"bike.png", @"run.png", nil][activityType]];
}
@end
