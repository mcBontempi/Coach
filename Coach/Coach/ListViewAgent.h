#import <Foundation/Foundation.h>

#import "ListViewControllerDelegate.h"
#import "ToListViewControllerDelegate.h"
#import "Model.h"
#import "ListViewAgentDelegate.h"

@interface ListViewAgent : NSObject  <ListViewControllerDelegate>

@property (nonatomic, weak) id<ToListViewControllerDelegate> toListViewControllerDelegate;

-(id) initWithModel:(Model *) model delegate:(id<ListViewAgentDelegate>) delegate;

@end
