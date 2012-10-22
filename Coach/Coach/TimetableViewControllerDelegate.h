#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol TimetableViewControllerDelegate <NSObject>

-(NSArray*) currentWeek;

@end
