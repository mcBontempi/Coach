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

-(void) ListViewControllerDelegate_actionItemPressed:(NSInteger) itemIndex{

    NSString *title = self.actionItemArray[itemIndex];
    
    if([title isEqualToString:KMENUITEM_NEWTIMETABLE]){
        [self.delegate ListViewAgentDelegate_newTimetable];
    }
}

@end