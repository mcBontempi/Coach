#import <Foundation/Foundation.h>

@protocol ListViewControllerDelegate <NSObject>

-(void) ListViewControllerDelegate_showWeek:(NSInteger) weekIndex;
-(NSInteger) ListViewControllerDelegate_numberOfWeeks;

@end
