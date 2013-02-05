#import "Slot.h"

@implementation Slot

-(id) initWithSlot:(Slot*) slot{
    if(self = [self initWithDuration:slot.duration startTime:slot.start activityType:slot.activityType uid:slot.uid checked:slot.checked zone:slot.zone]){
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType uid:(NSString *)uid checked:(BOOL) checked zone:(TZone)zone{
    {
        if(self = [self initWithDuration:duration startTime: start activityType: activityType uid:uid checked:checked]){
            self.zone = zone;
        }
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType uid:(NSString *)uid checked:(BOOL) checked{
    {
        if(self = [self initWithDuration:duration startTime: start activityType: activityType uid:uid]){
            self.checked = checked;
        }
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType uid:(NSString *)uid{
    {
        if(self = [self initWithDuration: duration startTime: start activityType: activityType]){
            self.uid = uid;
        }
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType {
    
    if(self = [self initWithDuration:duration activityType:activityType]){
        self.start = start;
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType zone:(TZone) zone{
    if(self = [self initWithDuration:duration activityType:activityType]){
        self.zone = zone;
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType{
    
    if(self = [self init]){
        self.duration = duration /15 * 15;
        self.activityType = activityType;
        self.zone = 255;
    }
    
    return self;
}

-(id) init{
    if(self = [super init]) {
        
        if(!self.uid){
            CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
            self.uid = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
            CFRelease(newUniqueId);
        }
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:@(self.start) forKey:@"start"];
  [coder encodeObject:@(self.duration) forKey:@"duration"];
  [coder encodeObject:@(self.activityType) forKey:@"activityType"];
  [coder encodeObject:self.uid forKey:@"uuid"];
  [coder encodeObject:@(self.checked) forKey:@"checked"];
  [coder encodeObject:@(self.zone) forKey:@"zone"];
}

- (id)initWithCoder:(NSCoder *)decoder{
  
  if(self = [super init]){
    self.start = [[decoder decodeObjectForKey:@"start"] intValue];
    self.duration = [[decoder decodeObjectForKey:@"duration"] intValue];
    self.activityType = [[decoder decodeObjectForKey:@"activityType"] intValue];
    self.uid = [decoder decodeObjectForKey:@"uid"];
    self.checked = [[decoder decodeObjectForKey:@"checked"] intValue];
    self.zone = [[decoder decodeObjectForKey:@"zone"] intValue];
  }
  return self;
}

@end
