#import <Foundation/Foundation.h>

#import "TimetableViewControllerDelegate.h"
#import "ToTimetableViewControllerDelegate.h"
#import "Model.h"
#import "TimetableViewAgentDelegate.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<ToTimetableViewControllerDelegate> toTimetableViewControllerDelegate;

-(id) initWithModel:(Model *) model delegate:(id<TimetableViewAgentDelegate>) delegate;

@end
