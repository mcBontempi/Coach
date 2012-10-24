#import <Foundation/Foundation.h>

@protocol TimetableViewAgentToViewDelegate <NSObject>

-(void) reloadTable;
-(void) insertRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) removeRowAtIndexPath:(NSIndexPath *)indexPath;

@end
