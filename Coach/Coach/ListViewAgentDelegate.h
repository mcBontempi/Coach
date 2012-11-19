#import <Foundation/Foundation.h>

@protocol ListViewAgentDelegate <NSObject>
-(void) ListViewAgentDelegate_showThisWeek;
-(void) ListViewAgentDelegate_showWeek:(NSInteger) weekIndex;
@end
