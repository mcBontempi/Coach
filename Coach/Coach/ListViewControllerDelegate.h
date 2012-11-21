#import <Foundation/Foundation.h>

@protocol ListViewControllerDelegate <NSObject>

-(void) ListViewControllerDelegate_showWeek:(NSInteger) weekIndex;
-(NSInteger) ListViewControllerDelegate_numberOfWeeks;

-(NSInteger) ListViewControllerDelegate_actionItemCount;
-(NSString*) ListViewControllerDelegate_actionItem:(NSInteger) itemIndex;

-(void) ListViewControllerDelegate_actionItemPressed:(NSInteger) itemIndex;

@end
