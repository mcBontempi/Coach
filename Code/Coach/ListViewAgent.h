#import <Foundation/Foundation.h>
#import "ListViewControllerDelegate.h"
#import "ToListViewControllerDelegate.h"
#import "ModelDelegate.h"
#import "ListViewAgentDelegate.h"

@interface ListViewAgent : NSObject  <ListViewControllerDelegate>

@property (nonatomic, weak) id<ToListViewControllerDelegate> toListViewControllerDelegate;

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ListViewAgentDelegate>) delegate;

-(void) highlightCurrentWeek:(NSInteger) weekIndex;

@end
