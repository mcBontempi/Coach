#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotCellDelegate <NSObject>

-(void) SlotCellDelegate_activityTypeChanged:(TActivityType) activityType;

@end
