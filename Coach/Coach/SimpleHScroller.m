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
    
        self.backgroundColor = [UIColor lightGrayColor];
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,50,50)];
        view.backgroundColor = [UIColor greenColor];
        [self addSubview:view];
    
        self.pagingEnabled = YES;
        
        [self setup];
    }
    return self;
}


-(void) setFrame:(CGRect)frame{
    
    
}


-(void) setup{
    
    
    CGFloat x = 0;
    
    for(NSString *string in self.items){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,0,100,20)];
        
        label.text = string;
        
        [self addSubview:label];
        
        x+=100;
        
    }
    self.contentSize = CGSizeMake(x,100);
    
}


@end
