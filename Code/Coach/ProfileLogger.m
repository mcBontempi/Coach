#import "ProfileLogger.h"

@implementation ProfileLogger

+(void) logProfile:(Profile *)profile{
    
    DLog(@"-- Profile Start --");
    
    for(NSNumber *number in profile.array){
      DLog(@"%@", number);
    }

    DLog(@"-- Profile End --");
}

@end
