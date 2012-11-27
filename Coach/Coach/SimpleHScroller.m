#import "SimpleHScroller.h"

@interface SimpleHScroller ()
@property (nonatomic, strong) NSArray *items;

@end

@implementation SimpleHScroller

- (id)initWithFrame:(CGRect)frame items:(NSArray*) items
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.items = items;
    
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}




@end
