#import "TimetableViewController.h"
#import "Slot.h"
#import "DataUtil.h"
#import "Utils.h"
#import "HeaderView.h"
#import "SlotCell.h"
#import "SlotCreateCell.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Notifications.h"

const CGFloat KSlotCellHeight = 50;
const CGFloat KSlotTagHeight = 20;
const CGFloat KExpandedSlotHeight = 60;

@interface TimetableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *headerViews;
@property NSInteger lastSectionUpdatedWhenDragging;
@property (nonatomic, strong) Slot *slotBeingEdited;
@property (nonatomic) BOOL slotBeingCreated;
@property (nonatomic, strong) UIBarButtonItem *previousBarButtonItem;
@property (nonatomic) bool currentSlotWasChangedDuringEditing;
@end

@implementation TimetableViewController

-(id) init{
  NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
  [exception raise];
  return nil;
}

-(id) initWithDelegate:(id<TimetableViewControllerDelegate>) delegate{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"TimetableViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"TimetableViewController_iPad" bundle:nil];
  }
  if(self){
    self.delegate = delegate;
    
    NSMutableArray *tempArray = [[NSMutableArray alloc ] init];
    
    for(NSInteger i = 0 ; i < 7 ; i++){
      [tempArray addObject:[[HeaderView alloc] initWithFrame:CGRectMake(0,0,320,40)]];
    }
    
    self.headerViews = [NSArray arrayWithArray:tempArray];
    
    // ok, a bit iffy
    self.lastSectionUpdatedWhenDragging = -1;
    
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithTitle:@"<-" style:UIBarButtonItemStylePlain                                                                                               target:self
                                                                             action:@selector(bookmarksPressed)] animated:YES];
  }
  
  return self;
}

-(void) bookmarksPressed{
  [self.delegate TimetableViewControllerDelegate_bookmarksPressed];
}

-(void) viewDidLoad{
  [super viewDidLoad];
  
  [self setRightBarButtonEdit];
  
  if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
  }
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(slotEditSlotChanged:) name:TTTSlotEditSlotChanged object:nil];
}

- (void)slotEditSlotChanged:(NSNotification *)notification
{
  self.currentSlotWasChangedDuringEditing = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
  if(self.currentSlotWasChangedDuringEditing == YES || self.slotBeingCreated){
    self.currentSlotWasChangedDuringEditing = NO;
    
    NSIndexPath *indexPath = [self indexPathForSlot:self.slotBeingEdited];
    
    NSArray * reloadArray = @[indexPath];
    
    self.slotBeingEdited = nil;
    self.slotBeingCreated = NO;
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
    
    [self.delegate TimetableViewControllerDelegate_commitEditingWeek];

  }
  
  [super viewDidAppear:animated];
}

-(void) setRightBarButtonEdit{
  [self setRightBarButton:UIBarButtonSystemItemEdit];
}

-(void) setRightBarButtonDone{
  [self setRightBarButton:UIBarButtonSystemItemDone];
}

-(void) setRightBarButton:(UIBarButtonSystemItem)systemItem
{
  self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem
                                                                                      target:self
                                                                                      action:@selector(toggleEditPressed)];
  
}


-(void) addAddRows
{
  NSMutableArray *insertArray = [[NSMutableArray alloc] init];
  
  for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
    NSArray *day = self.currentWeek[dayIndex];
    [insertArray addObject:[NSIndexPath indexPathForRow:day.count inSection:dayIndex]];
  }
  [self.tableView beginUpdates];
  
  [self.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
  [self.tableView endUpdates];
  
}


-(void) deleteAddRows
{
  NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
  
  for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
    NSArray *day = self.currentWeek[dayIndex];
    [deleteArray addObject:[NSIndexPath indexPathForRow:day.count inSection:dayIndex]];
  }
  
  [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)toggleEditPressed
{
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  
  if(self.tableView.editing){
    
    [self.delegate TimetableViewControllerDelegate_editingModeChangedIsEditing:YES];
    
    // go into edit mode
    [self setRightBarButtonDone];
    
    self.previousBarButtonItem = self.navigationItem.leftBarButtonItem;
    
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    
    [self addAddRows];
  }
  else
  {
    // get this before we go messing with the data
    NSIndexPath *currentEditingIndexPath = [self indexPathForSlot:self.slotBeingEdited];
    
    [self.delegate TimetableViewControllerDelegate_editingModeChangedIsEditing:NO];
    
    // editing done
    [self setRightBarButtonEdit];
    [self.navigationItem setLeftBarButtonItem:self.previousBarButtonItem  animated:YES];
    
    [self.delegate TimetableViewControllerDelegate_commitEditingWeek];
    
    [self.tableView beginUpdates];
    [self deleteAddRows];
    self.slotBeingEdited = nil;
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:currentEditingIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
  }
}



-(void) deleteAllRows:(UITableViewRowAnimation) animation
{
  NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
  for(NSInteger section = 0 ; section < [self.tableView numberOfSections] ; section ++){
    for(NSInteger row = 0 ; row < [self.tableView numberOfRowsInSection:section] ; row++)
    {
      [deleteArray addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }
  }
  [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:animation];
}

-(void) addAllRows:(UITableViewRowAnimation) animation
{
  NSMutableArray *insertArray = [[NSMutableArray alloc] init];
  for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
    NSArray *day = self.currentWeek[dayIndex];
    
    for(NSInteger slotIndex = 0 ; slotIndex < day.count ; slotIndex++){
      [insertArray addObject:[NSIndexPath indexPathForRow:slotIndex inSection:dayIndex]];
    }
  }
  [self.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:animation];
  
}

-(void) cancelItemPressed
{
  
  self.slotBeingEdited = nil;
  
  [self.delegate TimetableViewControllerDelegate_editingModeChangedIsEditing:NO];
  
  [self.tableView beginUpdates];
  
  [self deleteAllRows:UITableViewRowAnimationFade];
  
  [self.delegate TimetableViewControllerDelegate_cancelEditingWeek];
  
  [self addAllRows:UITableViewRowAnimationFade];
  
  [self.tableView setEditing:!self.tableView.editing animated:YES];
  
  [self.tableView endUpdates];
  
  
  [self setRightBarButtonEdit];
  [self.navigationItem setLeftBarButtonItem:self.previousBarButtonItem animated:YES];
  
  [self updateAllHeaders];
}

-(NSArray*) currentWeek
{
  return [self.delegate TimetableViewControllerDelegate_currentWeek];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
  NSInteger sectionCount = [self.currentWeek count];
  
  return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
  NSInteger rowCount = [self.currentWeek[section] count];
  
  rowCount += self.tableView.isEditing ? 1 : 0;
  
  return rowCount;
}

-(Slot*) slotForRowAtIndexPath:(NSIndexPath*)indexPath
{
  NSArray* slots = self.currentWeek[indexPath.section];
  if(indexPath.row >= slots.count) return nil;
  Slot *slot = slots[indexPath.row];
  
  return slot;
}

-(NSIndexPath*) indexPathForSlot:(Slot*) slot
{
  for(NSInteger section = 0 ; section < 7 ; section++){
    NSArray* day = self.currentWeek[section];
    for(NSInteger row = 0 ; row < day.count ; row++){
      if(slot == day[row]){
        NSLog(@"%d  %d", section, row);
        return [NSIndexPath indexPathForRow:row inSection:section];
      }
    }
  }
  return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray* slots = self.currentWeek[indexPath.section];
  
  if(indexPath.row >= slots.count){
    // this is an add row
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Add"];
    if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Add"];
      cell.selectionStyle = UITableViewCellSelectionStyleBlue;
      cell.textLabel.textColor = [UIColor blackColor];
      cell.textLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:18.0];
      cell.textLabel.text = @"Tap to add...";
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
  }
  else{
    
    if(self.slotBeingEdited == [self slotForRowAtIndexPath:indexPath]){
      
      SlotCreateCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SlotCreating"];
      if (cell == nil) {
        cell = [[SlotCreateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SlotCreating" delegate:self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      }
      
      [cell setup];
      
      return cell;;
    }
    else{
      SlotCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Slot"];
      if (cell == nil) {
        cell = [[SlotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Slot" delegate:self];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
      }
      
      Slot *slot = [self slotForRowAtIndexPath:indexPath];
      [cell setupWithChecked:slot.checked duration:slot.duration activityType:slot.activityType tags:slot.tags athleteNotes:slot.athleteNotes coachNotes:slot.coachNotes];
      
      return cell;
      
    }
    
  }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Slot *slot = [self slotForRowAtIndexPath:indexPath];
	if(slot && self.slotBeingEdited == [self slotForRowAtIndexPath:indexPath])
		return KExpandedSlotHeight;
  else
  {
    return KSlotCellHeight;
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 // if(self.tableView.isEditing){
    NSArray* slots = self.currentWeek[indexPath.section];
    if(indexPath.row >= slots.count){
      self.slotBeingCreated = YES;
      [self addSlotAtIndexPath: indexPath];
      [self newCreateItemSelectionAtIndexPath: indexPath];
    }
    else{
      self.slotBeingCreated = NO;
      self.slotBeingEdited = [self slotForRowAtIndexPath:indexPath];
      
      [self.delegate TimetableViewControllerDelegate_showFullscreenEditorForSlot:self.slotBeingEdited];
    }
  //}
//  else{
    
//  }
  
}

- (void)newCreateItemSelectionAtIndexPath:(NSIndexPath *)indexPath
{
  NSMutableArray *reloadArray = [[NSMutableArray alloc] initWithObjects:indexPath, nil];
  
  // we want to update the last selected cell
  if((self.slotBeingEdited && self.slotBeingEdited!= [self slotForRowAtIndexPath:indexPath])){
    [reloadArray addObject:[self indexPathForSlot:self.slotBeingEdited]];
  }
  
  if(self.slotBeingEdited == [self slotForRowAtIndexPath:indexPath]){
    self.slotBeingEdited = nil;
  }
  else{
    self.slotBeingEdited= [self slotForRowAtIndexPath:indexPath];
  }
  [self.tableView beginUpdates];
  [self.tableView reloadRowsAtIndexPaths:reloadArray withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView endUpdates];
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    
    Slot *slot = self.currentWeek[indexPath.section][indexPath.row];
    
    if(slot == self.slotBeingEdited){ self.slotBeingEdited = nil;}
    
    [self.tableView beginUpdates];
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    [deleteArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
    [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationLeft];
    [self.delegate TimetableViewControllerDelegate_deleteItem:slot];
    [self.tableView endUpdates];
    
    [self updateHeaderViewForSection:indexPath.section];
    
    [Utils playSound:@"delete" type:@"wav"];
    
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    
    [self addSlotAtIndexPath:indexPath];
    [self newCreateItemSelectionAtIndexPath: indexPath];
    
    
    [Utils playSound:@"delete" type:@"wav"];
  }
}


-(void) addSlotAtIndexPath:(NSIndexPath*) indexPath{
  [self.tableView beginUpdates];
  NSMutableArray *addArray = [[NSMutableArray alloc] init];
  [addArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
  [self.tableView insertRowsAtIndexPaths:addArray withRowAnimation:UITableViewRowAnimationLeft];
  [self.delegate TimetableViewControllerDelegate_addItemForDay:indexPath.section];
  [self.tableView endUpdates];
  
  [self updateHeaderViewForSection:indexPath.section];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  if([self.currentWeek[indexPath.section] count] == indexPath.row){
    return UITableViewCellEditingStyleInsert;
  }
  
  return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if([self.currentWeek[indexPath.section] count] == indexPath.row){
    return NO;
  }
  
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
  [self.delegate TimetableViewControllerDelegate_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
  [self updateHeaderViewForSection:destinationIndexPath.section];
  [self updateHeaderViewForSection:sourceIndexPath.section];
  
  self.lastSectionUpdatedWhenDragging = -1;
  
  
  [self.delegate TimetableViewControllerDelegate_commitEditingWeek];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
  
  if(self.tableView.isEditing){
    
    if(proposedDestinationIndexPath.section ==  sourceIndexPath.section &&
       proposedDestinationIndexPath.row == [self.currentWeek[proposedDestinationIndexPath.section] count]){
      
      proposedDestinationIndexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row -1 inSection:proposedDestinationIndexPath.section];
      
      
    }
    else if(proposedDestinationIndexPath.row > [self.currentWeek[proposedDestinationIndexPath.section] count]){
      proposedDestinationIndexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row -1 inSection:proposedDestinationIndexPath.section];
      
    }
  }
  
  // WE MOVE THE DATA AROUND HERE SO WE CAN CALC THE DAY TOTALS ETC
  [self.delegate TimetableViewControllerDelegate_moveRowAtIndexPath:sourceIndexPath toIndexPath:proposedDestinationIndexPath];
  
  [self updateHeaderViewForSection:proposedDestinationIndexPath.section];
  [self updateHeaderViewForSection:sourceIndexPath.section];
  if(self.lastSectionUpdatedWhenDragging != -1) [self updateHeaderViewForSection:self.lastSectionUpdatedWhenDragging];
  
  
  [self.delegate TimetableViewControllerDelegate_moveRowAtIndexPath:proposedDestinationIndexPath toIndexPath:sourceIndexPath];
  self.lastSectionUpdatedWhenDragging = proposedDestinationIndexPath.section;
  
  
  return proposedDestinationIndexPath;
}


-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  return nil;
  
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
  return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  return [self updatedHeaderViewForSection:section];
}

-(void) updateAllHeaders{
  for(NSInteger i = 0 ; i < self.headerViews.count ; i++){
    [self updateHeaderViewForSection:i];
  }
}


-(void) updateHeaderViewForSection:(NSInteger) section{
  
  UIView *view = [self updatedHeaderViewForSection:section];
  
  [view setNeedsDisplay];
}

-(HeaderView *) updatedHeaderViewForSection:(NSInteger) section
{
  HeaderView *headerView = self.headerViews[section];
  
  [headerView setText:[self.delegate TimetableViewControllerDelegate_daySummary:section]];
  return headerView;
}

-(void) reloadTable
{
  [self.tableView reloadData];
}

- (void)changeCurrentWeekAnimatedTo:(NSInteger) weekIndex
{
  [self.tableView beginUpdates];
  
  [self deleteAllRows:UITableViewRowAnimationFade];
  
  [self.delegate TimetableViewControllerDelegate_setWeekIndex:weekIndex];
  
  [self addAllRows:UITableViewRowAnimationFade];
  
  [self.tableView endUpdates];
  [self updateAllHeaders];
  
  self.title = [NSString stringWithFormat:@"Week %d", weekIndex+1];
  
}

-(void) ToTimetableViewControllerDelegate_changeCurrentWeekAnimatedTo:(NSInteger) weekIndex{
  
  [self changeCurrentWeekAnimatedTo:weekIndex];
  
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
  return YES;
}


-(void) updateHeaderViewForSlot:(Slot*) slot{
  NSIndexPath *indexPath = [self indexPathForSlot:slot];
  [self updatedHeaderViewForSection:indexPath.section];
}


-(void) SlotCreateCellDelegate_activityTypeChanged:(TActivityType) activityType
{
  [self.delegate TimetableViewControllerDelegate_activityTypeChanged:(TActivityType) activityType slot:self.slotBeingEdited];
  
  [self.delegate TimetableViewControllerDelegate_showFullscreenEditorForSlot:self.slotBeingEdited];
}

-(void) SlotEditingCellDelegate_durationChanged:(NSInteger) duration
{
  [self.delegate TimetableViewControllerDelegate_durationChanged:duration slot:self.slotBeingEdited];
  
  [self updateAllHeaders];
}

-(void) SlotCellDelegate_checked:(BOOL)checked identifier:(id) identifier
{
  [self.delegate TimetableViewControllerDelegate_checked:checked slot:[self slotForRowAtIndexPath:[self.tableView indexPathForCell:identifier]]];
}

@end
