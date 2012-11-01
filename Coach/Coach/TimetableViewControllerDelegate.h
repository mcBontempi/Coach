#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol TimetableViewControllerDelegate <NSObject>

-(NSArray*) TimetableViewControllerDelegate_currentWeek;

-(void) TimetableViewControllerDelegate_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

-(NSString *) TimetableViewControllerDelegate_daySummary:(NSInteger) day;

-(void) TimetableViewControllerDelegate_addItem;


@end
