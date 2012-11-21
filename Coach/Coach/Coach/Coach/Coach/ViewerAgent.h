#import <Foundation/Foundation.h>
#import "ModelDelegate.h"
#import "ListViewAgentDelegate.h"
#import "TimetableViewAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate, TimetableViewAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModelDelegate:(id<ModelDelegate>) model;
-(void) start;

@end
