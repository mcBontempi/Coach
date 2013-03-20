#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotCreateCellDelegate <NSObject>

-(void) SlotCreateCellDelegate_activityTypeChanged:(TActivityType) activityType;

@end
