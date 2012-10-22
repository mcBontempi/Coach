#import <Foundation/Foundation.h>

#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "Model.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;

-(id) initWithModel:(Model *) model;

@end
