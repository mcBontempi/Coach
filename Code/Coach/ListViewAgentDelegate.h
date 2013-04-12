#import <Foundation/Foundation.h>

@protocol ListViewAgentDelegate <NSObject>
-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex;
-(void) ListViewAgentDelegate_showPlansInFullscreen;
-(void) ListViewAgentDelegate_selectPlanFromPopover:(NSString *)planName;
@end
