#import <Foundation/Foundation.h>
#import "ListViewControllerDelegate.h"
#import "ToListViewControllerDelegate.h"
#import "ModelProtocol.h"
#import "ListViewAgentDelegate.h"

@interface ListViewAgent : NSObject  <ListViewControllerDelegate>

@property (nonatomic, weak) id<ToListViewControllerDelegate> toListViewControllerDelegate;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<ListViewAgentDelegate>)delegate;

- (void)highlightCurrentWeek:(NSInteger)weekIndex;

@end
