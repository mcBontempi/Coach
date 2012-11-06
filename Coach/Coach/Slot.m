#import "Slot.h"

@implementation Slot




-(id) initWithSlot:(Slot*) slot{
    if(self = [self initWithDuration:slot.duration startTime:slot.start activityType:slot.activityType]){
    }
    return self;
}

-(id) initWithDuration:(NSInteger) duration startTime:(NSInteger) start activityType:(TActivityType) activityType {

    if(self = [self initWithDuration:duration activityType:activityType]){
        self.start = start;
    }
    return self;
}


-(id) initWithDuration:(NSInteger) duration activityType:(TActivityType) activityType{

    if(self = [super init]){
        self.duration = duration;
        self.activityType = activityType;
    }

    return self;
}

@end
