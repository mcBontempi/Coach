#import <Foundation/Foundation.h>

#import "TimetableViewControllerDelegate.h"
#import "TimetableViewAgentDelegate.h"
#import "ToTimetableViewControllerDelegate.h"
#import "Model.h"
#import "ModelDelegate.h"

@interface TimetableViewAgent : NSObject  <TimetableViewControllerDelegate>

@property (nonatomic, weak) id<ToTimetableViewControllerDelegate> toTimetableViewControllerDelegate;

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<TimetableViewAgentDelegate>) delegate weekIndex:(NSInteger) weekIndex;
-(void) changeCurrentWeekAnimatedTo:(NSInteger) weekIndex;

@end
