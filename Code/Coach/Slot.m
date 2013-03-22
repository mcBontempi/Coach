#import "Slot.h"

@implementation Slot

- (id)initWithSlot:(Slot *)slot
{
  if(self = [self initWithDuration:slot.duration activityType:slot.activityType checked:slot.checked tags:slot.tags athleteNotes:slot.athleteNotes coachNotes:slot.coachNotes]){
  }
  return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType)activityType checked:(BOOL)checked tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString *)coachNotes
{
  {
    if(self = [self initWithDuration:duration activityType: activityType]){
      self.checked = checked;
      
      self.tags = tags;
      self.athleteNotes = athleteNotes;
      self.coachNotes = coachNotes;
    }
  }
  return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType
{
  
  if(self = [self init]){
    self.duration = duration /15 * 15;
    self.activityType = activityType;

    self.tags = @"";
    self.athleteNotes = @"";
    self.coachNotes = @"";
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:@(self.duration) forKey:@"duration"];
  [coder encodeObject:@(self.activityType) forKey:@"activityType"];
  [coder encodeObject:@(self.checked) forKey:@"checked"];
  [coder encodeObject:self.tags forKey:@"tags"];
  [coder encodeObject:self.athleteNotes forKey:@"athleteNotes"];
  [coder encodeObject:self.coachNotes forKey:@"coachNotes"];
  
}

- (id)initWithCoder:(NSCoder *)decoder{
  
  if(self = [super init]){
    self.duration = [[decoder decodeObjectForKey:@"duration"] intValue];
    self.activityType = [[decoder decodeObjectForKey:@"activityType"] intValue];
    self.checked = [[decoder decodeObjectForKey:@"checked"] intValue];
    self.tags = [decoder decodeObjectForKey:@"tags"];
    self.athleteNotes = [decoder decodeObjectForKey:@"athleteNotes"];
    self.coachNotes  = [decoder decodeObjectForKey:@"coachNotes"];
    
  }
  return self;
}


- (NSDictionary *) encodeIntoDictionary{
  return @{ @"duration":@(self.duration), @"activityType":@(self.activityType),@"checked":@(self.checked),@"tags":self.tags, @"athleteNotes":self.athleteNotes, @"coachNotes":self.coachNotes };
}

-(id) initWithDictionary:(NSDictionary *)dictionary {
  
  if([self initWithDuration:[[dictionary objectForKey:@"duration"] intValue] activityType:[[dictionary objectForKey:@"activityType"] intValue] checked:[[dictionary objectForKey:@"checked"] intValue] tags:[dictionary objectForKey:@"tags"] athleteNotes:[dictionary objectForKey:@"athleteNotes"] coachNotes:[dictionary objectForKey:@"coachNotes"]]){
    
  }
  return self;
}


@end
