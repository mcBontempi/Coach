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

@interface SlotEditTableViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tagsTextView;
@property (weak, nonatomic) IBOutlet UITextView *coachNotesTextView;
@property (weak, nonatomic) IBOutlet IconSelectionView *activityType;

@end

@implementation SlotEditTableViewController {
  __weak id<SlotEditViewControllerDelegate> _delegate;
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

- (void)setupNavigationBarButtons
{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                       target:self
                                                                                       action:@selector(cancelPressed)];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                        target:self
                                                                                        action:@selector(donePressed)];
}


- (void)donePressed
{
  //  [_delegate SlotEditViewControllerDelegate_updateWithActivityType:[self activityTpeForIndex:_activityType.currentItemIndex] duration:_hScroller.currentPage*15 tags:_tagsTextView.text athleteNotes:_athleteNotesTextView.text coachNotes:_coachNotesTextView.text];
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  
  [self setupTextFieldInitially:self.tagsTextView text:[_delegate SlotEditViewControllerDelegate_tags]];
  [self setupTextFieldInitially:self.coachNotesTextView text:[_delegate SlotEditViewControllerDelegate_coachNotes]];
   [self setupTextFieldInitially:self.athleteNotesTextView text:[_delegate SlotEditViewControllerDelegate_athleteNotes]];
   
   [self setupActivityType];
   
   self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"table_background_light.png"]];
   
   }
   
   
#pragma mark - Table view delegate
   
   - (CGFloat)heightForTextView:(UITextView*)textView
   {
     float horizontalPadding = 24;
     float verticalPadding = 36;
     float widthOfTextView = textView.contentSize.width - horizontalPadding;
     float height = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(widthOfTextView, 999999.0f) lineBreakMode:NSLineBreakByWordWrapping].height + verticalPadding;
     
     return height + 8;
   }
   
   - (void) textViewDidChange:(UITextView *)textView
   {
     [self.tableView beginUpdates];
     [self.tableView endUpdates];
   }
   
   - (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
   {
     
     switch(indexPath.section) {
       case 1:
         return [self heightForTextView:self.tagsTextView];
       case 2:
         return [self heightForTextView:self.coachNotesTextView];
       default:
         return [super tableView:tableView heightForRowAtIndexPath:indexPath];
     }
   }
   
   - (void)setupTextFieldInitially:(UITextView *)textView text:(NSString *)text {
     textView.text = text;
     float height = [self heightForTextView:textView];
     CGRect textViewRect = CGRectMake(74, 4, 280, height);
     textView.frame = textViewRect;
     textView.contentSize = CGSizeMake(280, [self heightForTextView:textView]);
   }
   
   
   - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
   {
     [self.tagsTextView resignFirstResponder];
     [self.coachNotesTextView resignFirstResponder];
   }
   
   
   
   
   
   - (void)setupActivityType
   {
     // activities selection
     NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
     
     for(NSNumber *number in [self activityTypeOrdering]){
       [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
     }
     
     [self.activityType setupWithImages:activityImageArray
                               iconSize:CGSizeMake(60,60)
                                padding:5
                               delegate:self];
     
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
   
   
   
   @end
