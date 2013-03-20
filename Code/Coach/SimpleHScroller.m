#import "SimpleHScroller.h"

@interface SimpleHScroller ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<SimpleHScrollerDelegate> hScrollerDelegate;

@end

@implementation SimpleHScroller

- (id)initWithPoint:(CGPoint)point items:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate{
    self = [super initWithFrame:CGRectMake(point.x,point.y, 150,30)];
    if (self) {
      [self setupWithItems:items delegate:hScrollerDelegate];
    }
    return self;
}

- (void)setupWithItems:(NSArray*) items delegate:(id<SimpleHScrollerDelegate>) hScrollerDelegate
{
  self.hScrollerDelegate = hScrollerDelegate;
  self.delegate = self;
  self.items = items;
  self.backgroundColor = [UIColor lightGrayColor];
  self.pagingEnabled = YES;
  self.bounces = NO;
  self.showsHorizontalScrollIndicator = NO;
  self.showsVerticalScrollIndicator = NO;
  [self setupLabels];
}

-(void) setupLabels{
    CGFloat x = 0;
  
    for(NSString *string in self.items){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,0,150,30)];
        
        label.text = string;
        label.textAlignment = UITextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.font=[UIFont fontWithName:@"Trebuchet MS" size:20.0];
        label.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubview:label];
        
        x+=150;
        
    }
    self.contentSize = CGSizeMake(x,50);
}

-(void) setDuration:(NSInteger) duration
{
    self.contentOffset = CGPointMake(150* ((duration/15)-1),0);
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
        int pageNum = (int)(self.contentOffset.x / self.frame.size.width) + 1;
    [self.hScrollerDelegate SimpleHScrollerDelegate_durationChanged:pageNum*15];
}
@end
