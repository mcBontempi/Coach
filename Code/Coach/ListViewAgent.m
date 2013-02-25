#import "ListViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface ListViewAgent ()

@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, weak) id<ListViewAgentDelegate> delegate;

@property (nonatomic, strong) NSArray *actionItemArray;

@end

@implementation ListViewAgent

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ListViewAgentDelegate>) delegate{
    self = [super init];
    if(self) {
        self.modelDelegate = modelDelegate;
        self.delegate = delegate;
        
        self.actionItemArray = @[KMENUITEM_NEWTIMETABLE];
        }
    return self;
}

-(void) highlightCurrentWeek:(NSInteger) weekIndex{
    [self.toListViewControllerDelegate ToListViewControllerDelegate_highlightCurrentWeek:weekIndex];
    
}

-(void) ListViewControllerDelegate_showWeek:(NSInteger) weekIndex{
    [self.delegate ListViewAgentDelegate_showWeek:weekIndex];
}

-(NSInteger) ListViewControllerDelegate_numberOfWeeks{
    return [self.modelDelegate weekCount];
}

-(NSInteger) ListViewControllerDelegate_actionItemCount{
    return self.actionItemArray.count;
}

-(NSString*) ListViewControllerDelegate_actionItem:(NSInteger) itemIndex{
    return self.actionItemArray[itemIndex];
}



-(void) ListViewControllerDelegate_showPlans{
   [self.delegate ListViewAgentDelegate_showPlansInFullscreen];
}

-(NSUInteger) ListViewControllerDelegate_numberOfPlans{
  return [self.modelDelegate planCount];
}

-(NSString *) ListViewControllerDelegate_getPlanName:(NSUInteger)index{
    return [self.modelDelegate planName:index];
}

-(void) ListViewControllerDelegate_showPlan:(NSString *)planName{
  [self.modelDelegate selectPlan:planName];
  [self.toListViewControllerDelegate ToListViewControllerDelegate_reloadData];
}

-(void) ListViewControllerDelegate_showPlansInFullscreen{
  [self.delegate ListViewAgentDelegate_showPlansInFullscreen];
}


@end