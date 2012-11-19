#import "ListViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface ListViewAgent ()

@property (nonatomic, weak) id<ModelDelegate> modelDelegate;
@property (nonatomic, weak) id<ListViewAgentDelegate> delegate;

@end

@implementation ListViewAgent

-(id) initWithModelDelegate:(id<ModelDelegate>) modelDelegate delegate:(id<ListViewAgentDelegate>) delegate{
    self = [super init];
    if(self) {
        self.modelDelegate = modelDelegate;
        self.delegate = delegate;
    }
    return self;
}

-(void) ListViewControllerDelegate_showThisWeek{
    
    [self.delegate ListViewAgentDelegate_showThisWeek];
}

-(void) ListViewControllerDelegate_showWeek:(NSInteger) weekIndex{
    [self.delegate ListViewAgentDelegate_showWeek:weekIndex];
}

-(NSInteger) ListViewControllerDelegate_numberOfWeeks{
    return [self.modelDelegate weekCount];
}

@end