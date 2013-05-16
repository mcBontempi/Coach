#import "ListViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"
#import "NSString_NiceStringFromDuration.h"

@interface ListViewAgent ()

@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, weak) id<ListViewAgentDelegate> delegate;

@property (nonatomic, strong) NSArray *actionItemArray;

@end

@implementation ListViewAgent{
  NSUInteger _weekIndex;
}

- (id)initWithModelProtocol:(id<ModelProtocol>)modelProtocol delegate:(id<ListViewAgentDelegate>)delegate
{
  self = [super init];
  if(self) {
    self.modelProtocol = modelProtocol;
    self.delegate = delegate;
    
    self.actionItemArray = @[KMENUITEM_NEWTIMETABLE];
  }
  return self;
}

- (void)highlightCurrentWeek:(NSInteger) weekIndex
{
  _weekIndex = weekIndex;
  [self.toListViewControllerDelegate ToListViewControllerDelegate_reloadData];
}


#pragma -- mark ListViewControllerDelegate methods

- (void)ListViewControllerDelegate_showWeek:(NSInteger) weekIndex
{
  _weekIndex = weekIndex;
  [self.delegate ListViewAgentDelegate_showWeek:weekIndex];
}

- (NSInteger)ListViewControllerDelegate_numberOfWeeks
{
  return [self.modelProtocol weekCount];
}

- (NSInteger)ListViewControllerDelegate_actionItemCount
{
  return self.actionItemArray.count;
}

- (NSString*)ListViewControllerDelegate_actionItem:(NSInteger)itemIndex
{
  return self.actionItemArray[itemIndex];
}

- (void)ListViewControllerDelegate_showPlans
{
  [self.delegate ListViewAgentDelegate_showPlansInFullscreen];
}

- (NSUInteger)ListViewControllerDelegate_numberOfPlans
{
  return [self.modelProtocol planCount];
}

- (NSString *)ListViewControllerDelegate_getPlanName:(NSUInteger)index
{
  return [self.modelProtocol planName:index];
}

-(void)ListViewControllerDelegate_showPlan:(NSString *)planName
{
  [self.delegate ListViewAgentDelegate_selectPlanFromPopover:planName];
}

-(void)ListViewControllerDelegate_showPlansInFullscreen
{
  [self.delegate ListViewAgentDelegate_showPlansInFullscreen];
}

-(NSString *)ListViewControllerDelegate_currentPlan
{
  return [self.modelProtocol currentPlan];
}

- (NSInteger) ListViewControllerDelegate_currentWeek
{
  return _weekIndex;
}

-(NSString *)ListViewControllerDelegate_weekSummary:(NSUInteger)week
{
  NSUInteger total = 0;
  
  for(NSArray *day in [self.modelProtocol getWeek:week]) {
    for(Slot *slot in day) {
      total += slot.duration;
    }
  }
  if(total) {
    return [NSString stringWithFormat:@"%@",  [NSString niceStringFromDuration:total]];
  }
  else {
    return @"";
  }
}

- (NSInteger)ListViewControllerDelegate_weekPercent:(NSUInteger)week
{
  float slotCount = 0;
  float slotCountCompleted = 0;
  
  for(NSArray *day in [self.modelProtocol getWeek:week]) {
    for(Slot *slot in day) {
      slotCount++;
      if(slot.checked)slotCountCompleted++;
    }
  }
  
  if(!slotCount) return 0;
  
  return (100/slotCount)*slotCountCompleted;
}



@end