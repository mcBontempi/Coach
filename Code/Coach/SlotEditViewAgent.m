#import "SlotEditViewAgent.h"

@interface SlotEditViewAgent ()
@property (nonatomic, weak) id<SlotEditViewAgentDelegate> delegate;
@property (nonatomic, strong) Slot *slot;
@end

@implementation SlotEditViewAgent

-(id) initWitSlot:(Slot *) slot delegate:(id<SlotEditViewAgentDelegate>) delegate
{
  self = [super init];
  if(self) {
    self.slot = slot;
    self.delegate = delegate;
  }
  return self;
}

@end