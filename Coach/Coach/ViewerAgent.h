#import <Foundation/Foundation.h>
#import "Model.h"
#import "ListViewAgentDelegate.h"

@interface ViewerAgent : NSObject <ListViewAgentDelegate>

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModel:(Model *) model;
-(void) start;

@end
