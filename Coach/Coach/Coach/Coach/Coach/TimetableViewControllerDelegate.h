#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Slot.h"

@protocol TimetableViewControllerDelegate <NSObject>

-(NSArray*) TimetableViewControllerDelegate_currentWeek;

-(void) TimetableViewControllerDelegate_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

-(NSString *) TimetableViewControllerDelegate_daySummary:(NSInteger) day;

-(void) TimetableViewControllerDelegate_addItemForDay:(NSInteger) dayIndex;
-(void) TimetableViewControllerDelegate_deleteItem:(Slot*) slot;

-(void) TimetableViewControllerDelegate_startEditingWeek;
-(void) TimetableViewControllerDelegate_commitEditingWeek;
-(void) TimetableViewControllerDelegate_cancelEditingWeek;

-(NSInteger) TimetableViewControllerDelegate_weekIndex;
-(void) TimetableViewControllerDelegate_setWeekIndex:(NSInteger) weekIndex;

-(void) TimetableViewControllerDelegate_editingModeChangedIsEditing:(BOOL) editing;
-(void) TimetableViewControllerDelegate_bookmarksPressed;


@end
