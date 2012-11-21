#import "DataUtil.h"

@implementation NSString (NiceStringFromDuration)

+(NSString*) niceStringFromDuration:(NSInteger) duration{
   
    NSInteger hours = duration /60;
    
    NSInteger minutes  = duration - (hours *60);
    
    if(hours && minutes)
        return [NSString stringWithFormat:@"%d hrs %d mins", hours, minutes];
    else if (hours)
        return  [NSString stringWithFormat:@"%d hrs", hours];
    else
        return  [NSString stringWithFormat:@"%d mins", minutes];
}


@end


