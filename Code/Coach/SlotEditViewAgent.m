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


- (Slot *)SlotEditViewControllerDelegate_currentSlot
{
  return self.slot;
}


- (TActivityType)SlotEditViewControllerDelegate_currentSlotActivityType
{
  return self.slot.activityType;
}

- (void)SlotEditViewControllerDelegate_currentSlotActivityTypeChanged:(TActivityType)activityType
{
  self.slot.activityType = activityType;
}

- (NSInteger)SlotEditViewControllerDelegate_currentSlotDuration
{
  return self.slot.duration;
}

- (void)SlotEditViewControllerDelegate_currentSlotDurationChanged:(NSInteger)duration
{
  self.slot.duration = duration;
}




@end