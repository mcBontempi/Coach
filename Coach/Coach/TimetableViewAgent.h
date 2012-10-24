#import <Foundation/Foundation.h>

#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentToViewDelegate.h"
#import "Model.h"
#import "TimetableViewAgentDelegate.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<TimetableViewAgentToViewDelegate> toViewDelegate;

-(id) initWithModel:(Model *) model delegate:(id<TimetableViewAgentDelegate>) delegate;

@end
