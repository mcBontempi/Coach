//
//  SlotEditTableViewController.m
//  Coach
//
//  Created by daren taylor on 23/05/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import "SlotEditTableViewController.h"
#import "UIImage_ImageForActivityType.h"
#import "IconSelectionView.h"
#import "PSAnalogClockView.h"
#import "KTOneFingerRotationGestureRecognizer.h"

@interface SlotEditTableViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tagsTextView;
@property (weak, nonatomic) IBOutlet UITextView *coachNotesTextView;
@property (weak, nonatomic) IBOutlet IconSelectionView *activityType;
@property (weak, nonatomic) IBOutlet UITextView *athleteNotesTextView;
@property (weak, nonatomic) IBOutlet UIView *clockContainer;

@end

@implementation SlotEditTableViewController {
  __weak id<SlotEditViewControllerDelegate> _delegate;
  
  PSAnalogClockView *_analogClockView;
  
  CGFloat _duration;
}


-(id) initWithDelegate:(id<SlotEditViewControllerDelegate>) delegate
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SlotEdit" bundle:nil];
    self = [storyboard instantiateInitialViewController];
  } else {
    self = [super initWithNibName:@"SlotEditTableViewController_iPad" bundle:nil];
  }
  if(self){
    _delegate = delegate;
    [self setupNavigationBarButtons];
  }
  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  [self setupTextFieldInitially:self.tagsTextView text:[_delegate SlotEditViewControllerDelegate_tags]];
  [self setupTextFieldInitially:self.coachNotesTextView text:[_delegate SlotEditViewControllerDelegate_coachNotes]];
  [self setupTextFieldInitially:self.athleteNotesTextView text:[_delegate SlotEditViewControllerDelegate_athleteNotes]];
  [self setupActivityType];
  
  self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_background_light.png"]];
  
  [self setupClock];
  
}


- (void)setupNavigationBarButtons
{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                       target:self
                                                                                       action:@selector(cancelPressed)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                        target:self
                                                                                        action:@selector(donePressed)];
}

#pragma mark - Actions

- (void)donePressed
{
  [_delegate SlotEditViewControllerDelegate_updateWithActivityType:[self activityTpeForIndex:_activityType.currentItemIndex] duration:_analogClockView.totalMinutes tags:_tagsTextView.text athleteNotes:_athleteNotesTextView.text coachNotes:_coachNotesTextView.text];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate

- (CGFloat)heightForTextView:(UITextView*)textView
{
  NSString *string = @"B";
  
  if(textView.text.length) {
    string = textView.text;
    NSUInteger endIndex = [textView.text length];
    endIndex--;
    if ([[textView.text substringFromIndex:endIndex] isEqualToString:@"\n"]) {
      string = [textView.text stringByAppendingString:@"B"];
    }
  }
  
  
  float verticalPadding = 36;
  float widthOfTextView = textView.contentSize.width;
  float height = [string sizeWithFont:textView.font constrainedToSize:CGSizeMake(widthOfTextView, 999999.0f) lineBreakMode:NSLineBreakByWordWrapping].height + verticalPadding;
  
  NSLog(@"height = %f", height);
  
  return height;
}

- (void) textViewDidChange:(UITextView *)textView
{
  [self.tableView beginUpdates];
  [self.tableView endUpdates];
}


- (void)setupTextFieldInitially:(UITextView *)textView text:(NSString *)text {
  textView.text = text;
  textView.contentSize = CGSizeMake(262, [self heightForTextView:textView]);
}


#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch(indexPath.section) {
    case 0:
      return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    case 1:
      return [self heightForTextView:self.tagsTextView];
    case 2:
      return [self heightForTextView:self.coachNotesTextView];
    case 3:
      return [self heightForTextView:self.athleteNotesTextView];
    default:
      assert(0);
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  [self.tagsTextView resignFirstResponder];
  [self.coachNotesTextView resignFirstResponder];
}

#pragma mark - ActivityType

- (void)setupActivityType
{
  // activities selection
  NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
  
  for(NSNumber *number in [self activityTypeOrdering]){
    [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
  }
  
  [self.activityType setupWithImages:activityImageArray
                            iconSize:CGSizeMake(50,50)
                             padding:5
                            delegate:self
                             numCols:2];
  
  [self.activityType setSelectedIndex:[_delegate SlotEditViewControllerDelegate_activityType]];
  
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

#pragma mark - clock

- (CGFloat) degreesToRadians:(CGFloat) degrees
{
  return degrees * M_PI / 180;
}

- (CGFloat) radiansToDegrees:(CGFloat) radians
{
  return radians * 180 / M_PI;
}

- (void)rotating:(KTOneFingerRotationGestureRecognizer *)recognizer
{
  CGFloat rotation =  [recognizer rotation];
  
  CGFloat degrees = [self radiansToDegrees:rotation];
  
  if (degrees > 300) degrees-=360;
  
  if (degrees < -300) degrees+=360;
  
  (_duration+= (degrees/6)) ;
  
  _analogClockView.totalMinutes = _duration;
}


- (void)setupClock
{
  _analogClockView = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(0,0,105,105)];
  _analogClockView.clockFaceImage  = [UIImage imageNamed:@"ClockFace"];
  _analogClockView.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  _analogClockView.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
  _analogClockView.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  [self.clockContainer addSubview:_analogClockView];
  KTOneFingerRotationGestureRecognizer *rotation = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)];
  [_analogClockView addGestureRecognizer:rotation];
  _duration = [_delegate SlotEditViewControllerDelegate_duration];
  _analogClockView.totalMinutes = _duration;
}



@end
