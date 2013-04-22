#import <Foundation/Foundation.h>

@protocol ListViewControllerDelegate <NSObject>

- (void)ListViewControllerDelegate_showWeek:(NSInteger)weekIndex;
- (NSInteger)ListViewControllerDelegate_numberOfWeeks;
- (NSInteger)ListViewControllerDelegate_actionItemCount;
- (NSString *)ListViewControllerDelegate_actionItem:(NSInteger)itemIndex;
- (void)ListViewControllerDelegate_showPlans;
- (NSString *)ListViewControllerDelegate_currentPlan;
- (NSInteger)ListViewControllerDelegate_currentWeek;

- (NSUInteger)ListViewControllerDelegate_numberOfPlans;
- (NSString *)ListViewControllerDelegate_getPlanName:(NSUInteger)index;
- (void)ListViewControllerDelegate_showPlan:(NSString *)planName;
- (void)ListViewControllerDelegate_showPlansInFullscreen;

- (NSString *)ListViewControllerDelegate_weekSummary:(NSUInteger) weekIndex;

@end
