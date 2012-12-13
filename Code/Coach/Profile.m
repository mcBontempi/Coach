#import "Profile.h"

@implementation Profile

-(void) generate{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    double percentageRange = (100- self.startPercentage);
    
    double percentageChange = percentageRange / (self.numberOfWeeks -1 );
    
    for(NSInteger i = 0 ; i < self.numberOfWeeks ; i++){
        
        double percentage = self.startPercentage + (i*percentageChange);
        
        [array addObject:@(percentage)];
    }
 
    self.array = array;
}

@end
