#import <Foundation/Foundation.h>
#import "ModelDelegate.h"
#import "ListViewAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModelDelegate:(id<ModelDelegate>) model;
-(void) start;

@end
