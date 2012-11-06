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
    self.week = [NSArray arrayWithArray:[self.modelDelegate getWeek:0]];
    
    self.week = [[NSMutableArray alloc] init];
    
    for(NSMutableArray *day in[self.modelDelegate getWeek:0] ){
        
        NSMutableArray *newDay = [[NSMutableArray alloc] init];
        [self.week addObject:newDay];
        for(Slot* slot in day){
            {
                Slot *newSlot = [[Slot alloc] initWithSlot:slot];
                [newDay addObject:newSlot];
            }
            
            
        }
        
    }
    
    
    NSLog(@"%@", self.week.description);
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

-(void) TimetableViewControllerDelegate_addItem{
    
    Slot *newSlot = [[Slot alloc ] initWithDuration:60 activityType:EActivityTypeBike];
    
    NSMutableArray *monday = self.week[0];
    
    [monday insertObject:newSlot atIndex:0];
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