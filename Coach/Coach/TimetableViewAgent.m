#import "TimetableViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface TimetableViewAgent ()

@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) NSMutableArray *week;

@end

@implementation TimetableViewAgent

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate{
    self = [super init];
    if(self) {
        self.modelDelegate = modelDelegate;
    }
    return self;
}

-(NSArray *) TimetableViewControllerDelegate_currentWeek{
    return self.currentWeek;
}

-(NSArray *) currentWeek{
    if(!self.week) {
        [self refetchCurrentWeek];
    }return self.week;
}

-(void) refetchCurrentWeek{
    self.week = [self.modelDelegate makeCopyOfWeek:[self.modelDelegate getWeek:0]];
}

-(void) saveCurrentWeek{
    [self.modelDelegate setWeek:0 array:[NSArray arrayWithArray:self.week]];
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
            return [NSString stringWithFormat:@"%@ - %d hrs %d mins", dayText, hours, minutes];
        else if (hours)
            return  [NSString stringWithFormat:@"%@ - %d hrs", dayText, hours];
        else
            return  [NSString stringWithFormat:@"%@ - %d mins", dayText, minutes];
        
    }
}

-(void) TimetableViewControllerDelegate_addItemForDay:(NSInteger) dayIndex{
    Slot *newSlot = [[Slot alloc ] initWithDuration:60 activityType:EActivityTypeBike];
    NSMutableArray *monday = self.week[dayIndex];
    [monday addObject:newSlot];
}

-(void) TimetableViewControllerDelegate_deleteItem:(Slot*) slot{
    
    for(NSInteger dayIndex= 0 ; dayIndex < self.week.count ; dayIndex++){
        NSMutableArray *day = self.week[dayIndex];
        [day removeObject:slot];
    }
}


-(void) TimetableViewControllerDelegate_startEditingWeek{
}

-(void) TimetableViewControllerDelegate_commitEditingWeek{
    [self saveCurrentWeek];
    [self refetchCurrentWeek];
}

-(void) TimetableViewControllerDelegate_cancelEditingWeek{
    [self refetchCurrentWeek];
}

@end