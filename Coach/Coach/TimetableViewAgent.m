#import "TimetableViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"
#import "NSString_NiceStringFromDuration.h"

@interface TimetableViewAgent ()

@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;
@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, strong) NSMutableArray *week;
@property NSInteger weekIndex;

@end

@implementation TimetableViewAgent

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<TimetableViewAgentDelegate>) delegate weekIndex:(NSInteger) weekIndex{
    self = [super init];
    if(self) {
        self.modelDelegate = modelDelegate;
        self.delegate = delegate;
        self.weekIndex = weekIndex;
    }
    return self;
}

-(void) changeCurrentWeekAnimatedTo:(NSInteger) weekIndex{
    [self.toTimetableViewControllerDelegate ToTimetableViewControllerDelegate_changeCurrentWeekAnimatedTo:weekIndex];
}

-(NSArray *) currentWeek{
    if(!self.week) {
        [self refetchCurrentWeek];
    }return self.week;
}

-(void) refetchCurrentWeek{
    self.week = [self.modelDelegate makeCopyOfWeek:[self.modelDelegate getWeek:self.weekIndex]];
}

-(void) saveCurrentWeek{
    [self.modelDelegate setWeek:self.weekIndex array:[NSArray arrayWithArray:self.week]];
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
        return [NSString stringWithFormat:@"%@ - %@", dayText, [NSString niceStringFromDuration:total]];
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


-(NSArray *) TimetableViewControllerDelegate_currentWeek{
    return self.currentWeek;
}

-(void) TimetableViewControllerDelegate_setWeekIndex:(NSInteger) weekIndex{
    self.weekIndex = weekIndex;
    [self refetchCurrentWeek];
}

-(NSInteger) TimetableViewControllerDelegate_weekIndex{
    return self.weekIndex;
}

-(void) TimetableViewControllerDelegate_editingModeChangedIsEditing:(BOOL) editing{
    [self.delegate TimetableViewAgentDelegate_editingModeChangedIsEditing:editing];
    
}

-(void) TimetableViewControllerDelegate_bookmarksPressed{
    [self.delegate TimetableViewAgentDelegate_bookmarksPressed];
    
}


-(void) TimetableViewControllerDelegate_activityTypeChanged:(TActivityType) activityType slot:(Slot*) slot{
    // only modify stuff in this class
    slot.activityType = activityType;
    
}


@end