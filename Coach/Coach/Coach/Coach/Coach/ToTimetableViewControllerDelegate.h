#import <Foundation/Foundation.h>

@protocol ToTimetableViewControllerDelegate <NSObject>

-(void) changeCurrentWeekAnimatedTo:(NSInteger) weekIndex;

@end
