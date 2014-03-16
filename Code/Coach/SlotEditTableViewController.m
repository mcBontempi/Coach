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
#import "NSString_NiceStringFromDuration.h"
#import "ActivitySelectionViewController.h"
#import "NSString+NameForActivityType.h"

@interface SlotEditTableViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tagsTextView;
@property (weak, nonatomic) IBOutlet UITextView *coachNotesTextView;
@property (weak, nonatomic) IBOutlet IconSelectionView *iconSelectionView;
@property (weak, nonatomic) IBOutlet UITextView *athleteNotesTextView;
@property (weak, nonatomic) IBOutlet UIView *clockContainer;
@property (weak, nonatomic) IBOutlet UIButton *activityTypeButton;

@end

@implementation SlotEditTableViewController {
  __weak id<SlotEditViewControllerDelegate> _delegate;
  
  PSAnalogClockView *_analogClockView;
  
  CGFloat _duration;
  
  TActivityType _activityType;
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
  
  _activityType = [_delegate SlotEditViewControllerDelegate_activityType];
  
#ifdef GYMTIMETABLE
  self.iconSelectionView.hidden = YES;
  self.activityTypeButton.hidden = NO;
  [self setupButton];
#endif
  
#ifdef TRIATHLONTIMETABLE
  self.iconSelectionView.hidden = NO;
  self.activityTypeButton.hidden = YES;
  [self setupIconSelectionView];
#endif
  
  
  [self setupTextFieldInitially:self.tagsTextView text:[_delegate SlotEditViewControllerDelegate_tags]];
  [self setupTextFieldInitially:self.coachNotesTextView text:[_delegate SlotEditViewControllerDelegate_coachNotes]];
  [self setupTextFieldInitially:self.athleteNotesTextView text:[_delegate SlotEditViewControllerDelegate_athleteNotes]];
  
  self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_background_light.png"]];
  
  [self setupClock];
  
  self.title = [NSString niceStringFromDuration:_analogClockView.totalMinutes];
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
  
  
  #ifdef GYMTIMETABLE
  [_delegate SlotEditViewControllerDelegate_updateWithActivityType:_activityType duration:_analogClockView.totalMinutes tags:_tagsTextView.text athleteNotes:_athleteNotesTextView.text coachNotes:_coachNotesTextView.text];
#endif 
  
#ifdef TRIATHLONTIMETABLE
  [_delegate SlotEditViewControllerDelegate_updateWithActivityType:[self activityTpeForIndex:self.iconSelectionView.currentItemIndex] duration:_analogClockView.totalMinutes tags:_tagsTextView.text athleteNotes:_athleteNotesTextView.text coachNotes:_coachNotesTextView.text];
#endif
  
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

#pragma mark - iconSelectionView

- (void)setupIconSelectionView
{
  // activities selection
  NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
  
  for(NSNumber *number in [self activityTypeOrdering]){
    [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
  }
  
  [self.iconSelectionView setupWithImages:activityImageArray
                                 iconSize:CGSizeMake(50,50)
                                  padding:5
                                 delegate:self
                                  numCols:2];
  
  [self.iconSelectionView setSelectedIndex:_activityType];
  
}

- (void)setupButton
{
  UIImage *image = [UIImage imageForActivityType:_activityType];
  [self.activityTypeButton setBackgroundImage:image forState:UIControlStateNormal];
}

#ifdef TRIATHLONTIMETABLE
-(NSArray*) activityTypeOrdering{
  return @[@(EActivityTypeSwim), @(EActivityTypeBike), @(EActivityTypeRun), @(EActivityTypeStrengthAndConditioning)];
}
#endif


#ifdef GYMTIMETABLE
-(NSArray*) activityTypeOrdering{
  return @[
           @(EActivityType8_stack_multi_station_small),
           @(EActivityTypeleg_extension_small),
           @(EActivityTypeabdominal_crunch_bench_small),
           @(EActivityTypeleg_press_small),
           @(EActivityTypeabdominal_small),
           @(EActivityTypemedicine_ball_small),
           @(EActivityTypeadjustable_bench_small),
           @(EActivityTypemulti_adjustable_bench_small),
           @(EActivityTypeadjustable_decline_bench_small),
           @(EActivityTypemultimode_rope_climber_small),
           @(EActivityTypearm_curl_small),
           @(EActivityTypeolympic_bar_small),
           @(EActivityTypeascent_trainer_small),
           @(EActivityTypepectoral_fly_small),
           @(EActivityTypeback_extension_small),
           @(EActivityTypepower_station_small),
           @(EActivityTypecalf_press_small),
           @(EActivityTypeprone_leg_curl_small),
           @(EActivityTypechest_press_small),
           @(EActivityTyperear_delt_fly_small),
           @(EActivityTypeconverging_chest_press_small),
           @(EActivityTyperecumbent_cycle_small),
           @(EActivityTypeconverging_shoulder_press_small),
           @(EActivityTyperotary_hip_small),
           @(EActivityTypedip_chin_assist_small),
           @(EActivityTyperotary_torso_small),
           @(EActivityTypediverging_lat_pulldown_small),
           @(EActivityTyperower_small),
           @(EActivityTypediverging_seated_row_small),
           @(EActivityTypeseated_dip_small),
           @(EActivityTypedumbbells_small),
           @(EActivityTypeseated_leg_curl_small),
           @(EActivityTypeelliptical_trainer_small),
           @(EActivityTypeseated_row_small),
           @(EActivityTypefunctional_trainer_small),
           @(EActivityTypeshoulder_press_small),
           @(EActivityTypehip_abductor_small),
           @(EActivityTypesmith_machine_small),
           @(EActivityTypehip_adductor_small),
           @(EActivityTypespinner_bike_small),
           @(EActivityTypehybrid_cycle_small),
           @(EActivityTypestepper_small),
           @(EActivityTypeindoor_cycle_small),
           @(EActivityTypetreadmill_small),
           @(EActivityTypekettlebells_small),
           @(EActivityTypetriceps_extension_small),
           @(EActivityTypelat_pull_small),
           @(EActivityTypeupright_cycle_small)];
 }
#endif

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
  
  if (_duration < 0) {
    _duration = 0;
  }
  
  NSInteger integerDuration = _duration;
  
  BOOL clockSnap = [_delegate SlotEditViewControllerDelegate_clockSnap];
  
  _analogClockView.totalMinutes = clockSnap ? integerDuration/5*5 : integerDuration;
  
  self.title = [NSString niceStringFromDuration:_analogClockView.totalMinutes];
}


- (void)setupClock
{
  _analogClockView = [[PSAnalogClockView alloc] initWithFrame:CGRectMake(0,0,105,105)];
  _analogClockView.clockFaceImage  = [_delegate SlotEditViewControllerDelegate_clockSnap] ? [UIImage imageNamed:@"ClockFaceSnap"]: [UIImage imageNamed:@"ClockFace"];
  _analogClockView.hourHandImage   = [UIImage imageNamed:@"clock_hour_hand"];
  _analogClockView.minuteHandImage = [UIImage imageNamed:@"clock_minute_hand"];
  _analogClockView.centerCapImage  = [UIImage imageNamed:@"clock_centre_point"];
  [self.clockContainer addSubview:_analogClockView];
  KTOneFingerRotationGestureRecognizer *rotation = [[KTOneFingerRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotating:)];
  [_analogClockView addGestureRecognizer:rotation];
  _duration = [_delegate SlotEditViewControllerDelegate_duration];
  _analogClockView.totalMinutes = _duration;
  
}

- (IBAction)clockWasLongPressed:(id)sender
{
  BOOL clockSnap = [_delegate SlotEditViewControllerDelegate_clockSnap];
  clockSnap = !clockSnap;
  
  _analogClockView.clockFaceImage  = clockSnap ? [UIImage imageNamed:@"ClockFaceSnap"]: [UIImage imageNamed:@"ClockFace"];
  
  [_delegate SlotEditViewControllerDelegate_setClockSnap:clockSnap];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"ActivitySelectSegue"]) {
    UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
    ActivitySelectionViewController *controller = (ActivitySelectionViewController *)navController.topViewController;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(NSNumber *number in [self activityTypeOrdering]){
      [array addObject:@{@"activityType": number, @"name": [NSString nameForActivityType:number.integerValue], @"imagePath" :  [UIImage imageForActivityType:number.integerValue]}];
    }
    controller.array = [array copy];
    controller.delegate = self;
    
    [controller.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self indexForActivityType:_activityType]  inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
  }
}



- (void)ActivitySelectionViewControllerDelegate_itemSlected:(NSUInteger)index
{
  NSNumber *activityTypeNumber = [self activityTypeOrdering][index];
  
  _activityType = activityTypeNumber.integerValue;
  
  [self setupButton];
}

- (void)ActivitySelectionViewControllerDelegate_Cancelled
{
  
}

@end
