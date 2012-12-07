#import <Foundation/Foundation.h>

@protocol TimetableViewAgentDelegate <NSObject>
-(void) TimetableViewAgentDelegate_editingModeChangedIsEditing:(BOOL) editing;
-(void) TimetableViewAgentDelegate_bookmarksPressed;

@end