#import "SlotEditViewController.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"
#import "SimpleHScroller.h"
#import "UIImage_ImageForActivityType.h"

@implementation SlotEditViewController{
  
  __weak id<SlotEditViewControllerDelegate> _delegate;
  __weak IBOutlet IconSelectionView *_activityType;
  __weak IBOutlet SimpleHScroller *_hScroller;
}

-(id) initWithDelegate:(id<SlotEditViewControllerDelegate>) delegate
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"SlotEditViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"SlotEditViewController_iPad" bundle:nil];
  }
  if(self){
    _delegate = delegate;
  }
  return self;
}

- (void)viewDidLoad
{
  [self setupActivityType];
  [self setuphScroller];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  _activityType.alpha = 0;
  _hScroller.alpha = 0;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];

  [UIView animateWithDuration:0.1 animations:^{   _activityType.alpha = 1;
  } completion:^(BOOL finished){
    [UIView animateWithDuration:0.1 animations:^{_hScroller.alpha=1;}]; } ];
  
  
  
}

- (void)setuphScroller
{
  // duration selection
  NSMutableArray *scrollerArray = [[NSMutableArray alloc] init];
  
  for(NSInteger i = 1 ; i <= 80 ; i++){
    [scrollerArray addObject:[NSString niceStringFromDuration:i*15]];
  }
  
  [_hScroller setupWithItems:scrollerArray delegate:self];
  [_hScroller setDuration:90];
  
  
  const CGFloat leftInset = _hScroller.frame.origin.x;
  const CGFloat rightInset = self.view.frame.size.width - (_hScroller.frame.origin.x + _hScroller.frame.size.width);
  _hScroller.responseInsets = UIEdgeInsetsMake(0, leftInset, 0, rightInset);
  
  
}

- (void)setupActivityType
{
  // activities selection
  NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
  
  for(NSNumber *number in [self activityTypeOrdering]){
    [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
  }
  
  [_activityType setupWithImages:activityImageArray
                        iconSize:CGSizeMake(40,40)
                         padding:5
                        delegate:self];
  
  [_activityType setSelectedIndex:2];
  
}

-(NSArray*) activityTypeOrdering{
  return @[@(EActivityTypeSwim), @(EActivityTypeBike), @(EActivityTypeRun), @(EActivityTypeStrengthAndConditioning)];
}

-(NSInteger) indexForActivityType:(TActivityType) activityType{
  for(NSInteger index = 0 ; index <  [self activityTypeOrdering].count ; index++){
    NSNumber *number = [self activityTypeOrdering][index];
    if(number.integerValue == activityType){
      return index;
    }
  }
  
  return 0;
}


-(void) SimpleHScrollerDelegate_durationChanged:(NSInteger) duration
{
  
}


-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex
{
  
  
}

@end
