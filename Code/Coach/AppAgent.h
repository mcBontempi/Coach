#import <Foundation/Foundation.h>

@interface AppAgent : NSObject

@property (nonatomic, strong) UIViewController *rootViewController;
-(void) start;
-(void) handleOpenURL:(NSURL *)url;
@end
