#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol SlotEditingCellDelegate <NSObject>

-(void) SlotEditingCellDelegate_activityTypeChanged:(TActivityType) activityType;
-(void) SlotEditingCellDelegate_durationChanged:(NSInteger) duration;
-(void) SlotEditingCellDelegate_zoneChanged:(TZone) zone;

@end
