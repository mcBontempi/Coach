#import "SimpleHScroller.h"

@interface SimpleHScroller ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<SimpleHScrollerDelegate> hScrollerDelegate;

@end

@implementation SimpleHScroller

- (id)initWithPoint:(CGPoint)point items:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate{
    self = [super initWithFrame:CGRectMake(point.x,point.y, 200,50)];
    if (self) {
        
        self.hScrollerDelegate = hScrollerDelegate;
        
        self.delegate = self;
        
        self.items = items;
    
        self.backgroundColor = [UIColor lightGrayColor];
    
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

-(void) setupWithDuration:(NSInteger) duration{
    
    CGFloat x = 0;
    
    for(NSString *string in self.items){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,0,200,50)];
        
        label.text = string;
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font=[UIFont fontWithName:@"Trebuchet MS" size:20.0];
        label.backgroundColor = [UIColor lightGrayColor];
        
        
        [self addSubview:label];
        
        x+=200;
        
    }
    self.contentSize = CGSizeMake(x,50);
    
    self.contentOffset = CGPointMake(200* ((duration/15)-1),0);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
        int pageNum = (int)(self.contentOffset.x / self.frame.size.width) + 1;
    [self.hScrollerDelegate SimpleHScrollerDelegate_durationChanged:pageNum*15];
}
@end
