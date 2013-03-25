#import "SlotEditViewAgent.h"
#import "Notifications.h"

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

- (TActivityType)SlotEditViewControllerDelegate_activityType
{
  return self.slot.activityType;
}

- (NSInteger)SlotEditViewControllerDelegate_duration
{
  return self.slot.duration;
}

- (NSString *)SlotEditViewControllerDelegate_tags
{
  return self.slot.tags;
}

- (NSString *)SlotEditViewControllerDelegate_athleteNotes
{
  return self.slot.athleteNotes;
}

- (NSString *)SlotEditViewControllerDelegate_coachNotes
{
  return self.slot.coachNotes;
}

- (void)SlotEditViewControllerDelegate_updateWithActivityType:(TActivityType)activityType duration:(NSInteger)duration tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString*)coachNotes
{
  
  if(self.slot.activityType != activityType ||
     self.slot.duration != duration ||
     ![self.slot.tags isEqualToString:tags] ||
     ![self.slot.athleteNotes isEqualToString:athleteNotes] ||
     ![self.slot.coachNotes isEqualToString:coachNotes]){
 
    [[NSNotificationCenter defaultCenter] postNotificationName:TTTSlotEditSlotChanged object:nil];
  }
  
  
  self.slot.activityType = activityType;
  self.slot.duration = duration;
  self.slot.tags = tags;
  self.slot.athleteNotes = athleteNotes;
  self.slot.coachNotes = coachNotes;

}



@end