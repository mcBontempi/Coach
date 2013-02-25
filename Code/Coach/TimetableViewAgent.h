#import <Foundation/Foundation.h>
#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ToTimetableViewControllerDelegate.h"
#import "Model.h"
#import "ModelProtocol.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<ToTimetableViewControllerDelegate> toTimetableViewControllerDelegate;

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<TimetableViewAgentDelegate>)delegate weekIndex:(NSInteger)weekIndex;
- (void)changeCurrentWeekAnimatedTo:(NSInteger)weekIndex;

@end
