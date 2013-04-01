#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol DurationViewControllerDelegate <NSObject>

-(void) DurationViewControllerDelegate_finishedWith:(NSInteger) duration name:(NSString *)name;

@end
