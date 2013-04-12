#import "ListViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface ListViewAgent ()

@property (nonatomic, strong) id<ModelProtocol> modelProtocol;
@property (nonatomic, weak) id<ListViewAgentDelegate> delegate;

@property (nonatomic, strong) NSArray *actionItemArray;

@end

@implementation ListViewAgent

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
  [self.toListViewControllerDelegate ToListViewControllerDelegate_reloadData];
  [self.toListViewControllerDelegate ToListViewControllerDelegate_highlightCurrentWeek:weekIndex];
}

#pragma -- mark ListViewControllerDelegate methods

- (void)ListViewControllerDelegate_showWeek:(NSInteger) weekIndex
{
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


@end