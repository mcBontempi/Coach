#import <Foundation/Foundation.h>
#import "Slot.h"

@interface SlotLogger : NSObject

+(void) logSlot:(Slot *)slot;
+(void) logSlots:(NSArray *)slots;

@end
