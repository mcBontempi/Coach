#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotEditViewControllerDelegate <NSObject>

- (TActivityType)SlotEditViewControllerDelegate_activityType;
- (NSInteger)SlotEditViewControllerDelegate_duration;
- (NSString *)SlotEditViewControllerDelegate_tags;
- (NSString *)SlotEditViewControllerDelegate_athleteNotes;
- (NSString *)SlotEditViewControllerDelegate_coachNotes;

- (void)SlotEditViewControllerDelegate_updateWithActivityType:(TActivityType)activityType duration:(NSInteger)duration tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString*)coachNotes;

@end
