#import "TimetableViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"
#import "NSString_NiceStringFromDuration.h"

@interface TimetableViewAgent ()

@property (nonatomic, weak) id<TimetableViewAgentDelegate> delegate;
@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, strong) NSMutableArray *week;
@property NSInteger weekIndex;

@end

@implementation TimetableViewAgent

-(id) initWithModelProtocol:(id<ModelProtocol>) modelProtocol delegate:(id<TimetableViewAgentDelegate>) delegate weekIndex:(NSInteger) weekIndex{
    self = [super init];
    if(self) {
        self.modelProtocol = modelProtocol;
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
    self.week = [self.modelProtocol makeCopyOfWeek:[self.modelProtocol getWeek:self.weekIndex]];
}

-(void) saveCurrentWeek{
    [self.modelProtocol setWeek:self.weekIndex array:[NSArray arrayWithArray:self.week]];
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

-(NSString *)TimetableViewControllerDelegate_weekSummary:(NSUInteger)week
{
  NSUInteger total = 0;
  
  for(NSArray *day in self.currentWeek){
    for(Slot *slot in day){
      total += slot.duration;
    }
  }
  
  return [NSString niceStringFromDuration:total];
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
    slot.activityType = activityType;
}

-(void) TimetableViewControllerDelegate_durationChanged:(NSInteger) duration slot:(Slot*) slot{
    slot.duration = duration;
}

- (void)TimetableViewControllerDelegate_showFullscreenEditorForSlot:(Slot *)slot
{
  [self.delegate TimetableViewAgentDelegate_showFullscreenEditorForSlot:slot];
}

-(void) TimetableViewControllerDelegate_checked:(BOOL)checked slot:(Slot *)slot{
    slot.checked = checked;
    
    [self saveCurrentWeek];
}

@end