#import <Foundation/Foundation.h>
#import "Model.h"
@interface ViewerAgent : NSObject

@property (nonatomic, strong) UIViewController *rootViewController;

-(id) initWithModel:(Model *) model;
-(void) start;

@end
