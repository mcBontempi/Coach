#import <Foundation/Foundation.h>

@protocol SimpleHScrollerDelegate <NSObject>

@optional

-(void) SimpleHScrollerDelegate_pageChanged:(NSInteger) duration;

@end
