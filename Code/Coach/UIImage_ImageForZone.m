
@implementation UIImage (ImageForZone)

+(UIImage *)imageForZone:(TZone)zone{
    switch(zone){
        case EZone1: return [UIImage imageNamed:@"z1.png"];
        case EZone2: return [UIImage imageNamed:@"z2.png"];
        case EZone3: return [UIImage imageNamed:@"z3.png"];
        case EZone4: return [UIImage imageNamed:@"z4.png"];
        case EZone5: return [UIImage imageNamed:@"z5.png"];
        default: return nil;
    }
}
@end
