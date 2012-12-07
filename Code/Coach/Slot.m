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

@end
