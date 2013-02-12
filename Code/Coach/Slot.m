#import "Slot.h"

@implementation Slot

-(id) initWithSlot:(Slot*) slot{
    if(self = [self initWithDuration:slot.duration activityType:slot.activityType checked:slot.checked]){
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType checked:(BOOL) checked{
    {
        if(self = [self initWithDuration:duration activityType: activityType]){
            self.checked = checked;
        }
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType{
    
    if(self = [self init]){
        self.duration = duration /15 * 15;
        self.activityType = activityType;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{ 
  [coder encodeObject:@(self.duration) forKey:@"duration"];
  [coder encodeObject:@(self.activityType) forKey:@"activityType"];
  [coder encodeObject:@(self.checked) forKey:@"checked"];
}

- (id)initWithCoder:(NSCoder *)decoder{
  
  if(self = [super init]){
    self.duration = [[decoder decodeObjectForKey:@"duration"] intValue];
    self.activityType = [[decoder decodeObjectForKey:@"activityType"] intValue];
    self.checked = [[decoder decodeObjectForKey:@"checked"] intValue];
  }
  return self;
}


- (NSDictionary *) encodeIntoDictionary{
  return @{ @"duration":@(self.duration), @"activityType":@(self.activityType),@"checked":@(self.checked)};
}

-(id) initWithDictionary:(NSDictionary *)dictionary {
  
  if([self initWithDuration:[[dictionary objectForKey:@"duration"] intValue] activityType:[[dictionary objectForKey:@"activityType"] intValue] checked:[[dictionary objectForKey:@"checked"] intValue]]){
    
  }
  return self;
}


@end
