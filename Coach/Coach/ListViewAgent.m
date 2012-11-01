#import "ListViewAgent.h"
#import "Slot.h"
#import "DataUtil.h"

@interface ListViewAgent ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, weak) id<ListViewAgentDelegate> delegate;

@end

@implementation ListViewAgent

-(id) initWithModel:(Model *) model delegate:(id<ListViewAgentDelegate>) delegate{
    self = [super init];
    if(self) {
        self.model = model;
        self.delegate = delegate;
    }
    return self;
}

-(void) ListViewControllerDelegate_showThisWeek{
    
    [self.delegate ListViewAgentDelegate_showThisWeek];
}

@end