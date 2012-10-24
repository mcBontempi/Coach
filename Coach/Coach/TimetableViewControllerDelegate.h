#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol TimetableViewControllerDelegate <NSObject>

-(NSArray*) currentWeek;

-(void) moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end
