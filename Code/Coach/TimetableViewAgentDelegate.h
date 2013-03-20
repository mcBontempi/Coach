#import <Foundation/Foundation.h>
#import "Slot.h"

@protocol TimetableViewAgentDelegate <NSObject>
- (void)TimetableViewAgentDelegate_editingModeChangedIsEditing:(BOOL) editing;
- (void)TimetableViewAgentDelegate_bookmarksPressed;
- (void)TimetableViewAgentDelegate_showFullscreenEditorForSlot:(Slot *)slot;

@end
