#import "TimetableViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface TimetableViewAgent ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *week;

@end

@implementation TimetableViewAgent

-(id) initWithModel:(Model *) model delegate:(id<TimetableViewAgentDelegate>) delegate{
    self = [super init];
    if(self) {
        self.model = model;
        self.delegate = delegate;
    }
    return self;
}

-(NSArray *) TimetableViewControllerDelegate_currentWeek{
    return self.currentWeek;
}

-(NSArray *) currentWeek{
    if(!self.week) {
        self.week = [NSArray arrayWithArray:self.model.weeks[0]];
    }return self.week;
}


-(void) TimetableViewControllerDelegate_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    Slot *slot = self.week[sourceIndexPath.section][sourceIndexPath.row];
    NSMutableArray *day = self.week[sourceIndexPath.section];
    [day removeObjectAtIndex:sourceIndexPath.row];
    day = self.week[destinationIndexPath.section];
    [day insertObject:slot atIndex:destinationIndexPath.row];
}

-(NSString *) TimetableViewControllerDelegate_daySummary:(NSInteger)day{
    NSString *dayText = [DataUtil weekdayFromWeekdayOrdinal:day];
    
    if(![self.currentWeek[day] count])
        return [NSString stringWithFormat:@"%@ - Rest Day", dayText];
    else
    {
        NSInteger total = 0;
        for(Slot *slot in self.currentWeek[day]){
            total += slot.duration;
        }
        
        
        NSInteger hours = total /60;
        
        NSInteger minutes  = total - (hours *60);
        
        if(hours && minutes)
            return [NSString stringWithFormat:@" %d hrs %d mins", hours, minutes];
        else if (hours)
            return  [NSString stringWithFormat:@" %d hrs", hours];
        else
            return  [NSString stringWithFormat:@" %d mins", minutes];
        
    }
}

@end