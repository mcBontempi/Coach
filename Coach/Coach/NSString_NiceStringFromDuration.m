#import "DataUtil.h"

@implementation NSString (NiceStringFromDuration)

+(NSString*) niceStringFromDuration:(NSInteger) duration{
   
    NSInteger hours = duration /60;
    
    NSInteger minutes  = duration - (hours *60);
    
    
    if(hours && minutes)
        return [NSString stringWithFormat:@"%d %@ %d %@", hours,[NSString hrText:hours], minutes, [NSString minText:minutes]];
    else if (hours)
        return  [NSString stringWithFormat:@"%d %@", hours, [NSString hrText:hours]];
    else
        return  [NSString stringWithFormat:@"%d %@", minutes, [NSString minText:minutes]];
}


+(NSString*) hrText:(NSInteger) hours {
    if(hours == 1){
        return @"hr";
    }
    else return @"hrs";
}

+(NSString*) minText:(NSInteger) mins {
    if(mins == 1){
        return @"min";
    }
    else return @"mins";
}


@end


