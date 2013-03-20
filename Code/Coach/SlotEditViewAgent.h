#import <Foundation/Foundation.h>
#import "SlotEditViewAgentDelegate.h"
#import "Slot.h"
#import "SlotEditViewControllerDelegate.h"

@interface SlotEditViewAgent : NSObject <SlotEditViewControllerDelegate>

-(id) initWitSlot:(Slot *) slot delegate:(id<SlotEditViewAgentDelegate>) delegate;

@end
