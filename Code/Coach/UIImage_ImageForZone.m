
@implementation UIImage (ImageForZone)

+(UIImage *)imageForZone:(TZone)zone{
    switch(zone){
        case EZone1: return [UIImage imageNamed:@"swim.png"];
        case EZone2: return [UIImage imageNamed:@"bike.png"];
        case EZone3: return [UIImage imageNamed:@"swim.png"];
        case EZone4: return [UIImage imageNamed:@"swim.png"];
        case EZone5: return [UIImage imageNamed:@"swim.png"];
        default: return nil;
    }
}
@end
