#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotEditViewControllerDelegate <NSObject>

- (TActivityType)SlotEditViewControllerDelegate_currentSlotActivityType;
- (void)SlotEditViewControllerDelegate_currentSlotActivityTypeChanged:(TActivityType)activityType;

- (NSInteger)SlotEditViewControllerDelegate_currentSlotDuration;
- (void)SlotEditViewControllerDelegate_currentSlotDurationChanged:(NSInteger)duration;

@end
