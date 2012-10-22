#import <Foundation/Foundation.h>

#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentDelegate.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;

@end
