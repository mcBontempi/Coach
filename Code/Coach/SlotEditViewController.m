#import "SlotEditViewController.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"
#import "SimpleHScroller.h"
#import "UIImage_ImageForActivityType.h"
#import "Slot.h"

@implementation SlotEditViewController{
  
  IBOutlet UIScrollView *_scrollView;
  __weak IBOutlet UITextView *_coachNotesTextView;
  __weak IBOutlet UITextView *_athleteNotesTextView;
  __weak id<SlotEditViewControllerDelegate> _delegate;
  __weak IBOutlet IconSelectionView *_activityType;
  __weak IBOutlet SimpleHScroller *_hScroller;
  
  __weak IBOutlet UITextView *_tagsTextView;
}

- (IBAction)scrollViewTapped:(id)sender {
  [UIView animateWithDuration:0.2 animations:^{
    _scrollView.contentOffset = CGPointMake(0,0);}];
  
  [_coachNotesTextView resignFirstResponder];
  [_athleteNotesTextView resignFirstResponder];
}

- (IBAction)donePressed:(id)sender
{
  [_delegate SlotEditViewControllerDelegate_updateWithActivityType:[self activityTpeForIndex:_activityType.currentItemIndex] duration:_hScroller.currentPage*15 tags:_tagsTextView.text athleteNotes:_athleteNotesTextView.text coachNotes:_coachNotesTextView.text];
  [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancelPressed:(id)sender
{
  [self dismissModalViewControllerAnimated:YES];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
  }
  return self;
}

- (void)viewDidLoad
{
  [self setupActivityType];
  [self setuphScroller];
  
  [self setupTags];
  [self setupAthleteNotes];
  [self setupCoachNotes];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  [UIView animateWithDuration:0.2 animations:^{
    _scrollView.contentOffset = CGPointMake(0,125);}];
}

- (void)setupTags
{
  _tagsTextView.text = [_delegate SlotEditViewControllerDelegate_tags];
  
}

- (void)setupAthleteNotes
{
  _athleteNotesTextView.text = [_delegate SlotEditViewControllerDelegate_athleteNotes];
}

- (void)setupCoachNotes
{
  _coachNotesTextView.text = [_delegate SlotEditViewControllerDelegate_coachNotes];
}

- (void)setuphScroller
{
  NSMutableArray *scrollerArray = [[NSMutableArray alloc] init];
  
  for(NSInteger i = 1 ; i <= 80 ; i++){
    [scrollerArray addObject:[NSString niceStringFromDuration:i*15]];
  }
  
  [_hScroller setupWithItems:scrollerArray delegate:self];
  [_hScroller setPage:[_delegate SlotEditViewControllerDelegate_duration]/15];
  
  
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
                        iconSize:CGSizeMake(60,60)
                         padding:5
                        delegate:self];
  
  [_activityType setSelectedIndex:[_delegate SlotEditViewControllerDelegate_activityType]];
  
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

-(TActivityType) activityTpeForIndex:(NSInteger) index
{
  NSNumber *number = [self activityTypeOrdering][index];
  return number.integerValue;
}

- (void)viewDidUnload {
  _scrollView = nil;
  [super viewDidUnload];
}
@end
