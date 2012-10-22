#import "TimetableViewAgent.h"
#import "Model.h"

@interface TimetableViewAgent ()

@property (nonatomic, strong) Model *model;

@end

@implementation TimetableViewAgent

-(id) initWithModel:(Model *) model{
    self = [super init];
    if(self) {
        self.model = model;
    }
    return self;
}

-(NSArray *) currentWeek{
    return self.model.weeks[0];
}

@end
