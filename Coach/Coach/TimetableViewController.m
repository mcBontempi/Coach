#import "TimetableViewController.h"
#import "Slot.h"
#import "DataUtil.h"
#import "Utils.h"
#import "HeaderView.h"
#import "SlotCell.h"

const CGFloat KSlotCellHeight = 40;
const CGFloat KExpandedSlotHeight = 70;

@interface TimetableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *headerViews;
@property NSInteger lastSectionUpdatedWhenDragging;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGestureRecognizer;

@property (nonatomic, strong) UIBarButtonItem *previousBarButtonItem;


@property (nonatomic, strong) NSMutableDictionary *selectedIndexes;
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
        
        self.lastSectionUpdatedWhenDragging = -1;
        
        
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                                               target:self
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
    
    self.selectedIndexes = [[NSMutableDictionary alloc] init];
}

-(void) setRightBarButtonEdit{
    [self setRightBarButton:UIBarButtonSystemItemEdit];
}

-(void) setRightBarButtonDone{
    [self setRightBarButton:UIBarButtonSystemItemDone];
}

-(void) setRightBarButton:(UIBarButtonSystemItem)systemItem {
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem
                                                                                        target:self
                                                                                        action:@selector(toggleEditPressed)];
    
}


-(void) addAddRows{
    NSMutableArray *insertArray = [[NSMutableArray alloc] init];
    
    for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
        NSArray *day = self.currentWeek[dayIndex];
        [insertArray addObject:[NSIndexPath indexPathForRow:day.count inSection:dayIndex]];
    }
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
}


-(void) deleteAddRows{
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    
    for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
        NSArray *day = self.currentWeek[dayIndex];
        [deleteArray addObject:[NSIndexPath indexPathForRow:day.count inSection:dayIndex]];
    }
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(void)toggleEditPressed{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if(self.tableView.editing){
        
        [self.delegate TimetableViewControllerDelegate_editingModeChangedIsEditing:YES];
        
        // go into edit mode
        [self setRightBarButtonDone];
        
        self.previousBarButtonItem = self.navigationItem.leftBarButtonItem;
        
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                               target:self
                                                                                               action:@selector(cancelItemPressed)] animated:YES];
        
        [self.delegate TimetableViewControllerDelegate_startEditingWeek];
        
        
        [self addAddRows];
    }
    else{
        
        [self.delegate TimetableViewControllerDelegate_editingModeChangedIsEditing:NO];
        
        // editing done
        [self setRightBarButtonEdit];
        [self.navigationItem setLeftBarButtonItem:self.previousBarButtonItem  animated:YES];
        
        [self.delegate TimetableViewControllerDelegate_commitEditingWeek];
        
        [self deleteAddRows];
    }
}

-(void) deleteAllRows:(UITableViewRowAnimation) animation{
    NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
    for(NSInteger section = 0 ; section < [self.tableView numberOfSections] ; section ++){
        for(NSInteger row = 0 ; row < [self.tableView numberOfRowsInSection:section] ; row++)
        {
            [deleteArray addObject:[NSIndexPath indexPathForRow:row inSection:section]];
        }
    }
    [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:animation];
}

-(void) addAllRows:(UITableViewRowAnimation) animation{
    NSMutableArray *insertArray = [[NSMutableArray alloc] init];
    for(NSInteger dayIndex = 0 ; dayIndex < self.currentWeek.count ; dayIndex++){
        NSArray *day = self.currentWeek[dayIndex];
        
        for(NSInteger slotIndex = 0 ; slotIndex < day.count ; slotIndex++){
            [insertArray addObject:[NSIndexPath indexPathForRow:slotIndex inSection:dayIndex]];
        }
    }
    [self.tableView insertRowsAtIndexPaths:insertArray withRowAnimation:animation];
    
}
-(void) cancelItemPressed{
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

-(NSArray*) currentWeek{
    return [self.delegate TimetableViewControllerDelegate_currentWeek];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger sectionCount = [self.currentWeek count];
    
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowCount = [self.currentWeek[section] count];
    
    rowCount += self.tableView.isEditing ? 1 : 0;
    
    NSLog(@"%d   %d     %d",section,  rowCount,  self.tableView.isEditing ? 1 : 0);
    
    return rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        }
        return cell;
    }
    else{

        // this is a slot row
        SlotCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Slot"];
        if (cell == nil) {
            cell = [[SlotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Slot"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.textLabel.textColor = [UIColor blueColor];
            UIColor *color = [UIColor whiteColor];
            cell.backgroundColor = color;
        }
        
        Slot *slot = slots[indexPath.row];
        cell.duration = slot.duration;
        cell.activityType = slot.activityType;
        
        cell.height = KSlotCellHeight;
        
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self cellIsSelected:indexPath])
		return KExpandedSlotHeight;
    else
        return KSlotCellHeight;
}

- (BOOL)cellIsSelected:(NSIndexPath *)indexPath {
	// Return whether the cell at the specified index path is selected or not
	NSNumber *selectedIndex = [self.selectedIndexes objectForKey:indexPath];
	return selectedIndex == nil ? FALSE : [selectedIndex boolValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didselect");
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:indexPath];
    // Store cell 'selected' state keyed on indexPath
    NSNumber *selectedIndex = [NSNumber numberWithBool:isSelected];
    [self.selectedIndexes setObject:selectedIndex forKey:indexPath];
    // This is where magic happens...
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
*/

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Slot *slot = self.currentWeek[indexPath.section][indexPath.row];
     
        [self.tableView beginUpdates];
        NSMutableArray *deleteArray = [[NSMutableArray alloc] init];
        [deleteArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
        [self.tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationLeft];
        [self.delegate TimetableViewControllerDelegate_deleteItem:slot];
        [self.tableView endUpdates];
        
        [self updateHeaderViewForSection:indexPath.section];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

        [self.tableView beginUpdates];
        NSMutableArray *addArray = [[NSMutableArray alloc] init];
        [addArray addObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]];
        [self.tableView insertRowsAtIndexPaths:addArray withRowAnimation:UITableViewRowAnimationLeft];
        [self.delegate TimetableViewControllerDelegate_addItemForDay:indexPath.section];
        [self.tableView endUpdates];
        
        [self updateHeaderViewForSection:indexPath.section];
    }
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
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    
    if(self.tableView.isEditing){
        
        
        NSInteger proposedRow = proposedDestinationIndexPath.row;
        NSInteger count = [self.currentWeek[proposedDestinationIndexPath.section] count];
        
        NSLog(@"proposed row = %d count = %d",proposedRow, count  );
        
        
        if(proposedDestinationIndexPath.section ==  sourceIndexPath.section &&
           proposedDestinationIndexPath.row == [self.currentWeek[proposedDestinationIndexPath.section] count]){
            
            proposedDestinationIndexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row -1 inSection:proposedDestinationIndexPath.section];
            
            NSLog(@"changed 1");
            
            
        }
        else if(proposedDestinationIndexPath.row > [self.currentWeek[proposedDestinationIndexPath.section] count]){
            proposedDestinationIndexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row -1 inSection:proposedDestinationIndexPath.section];
            
            NSLog(@"changed");
        }
    }
    
    NSLog(@"src = %d,%d  dst = %d,%d",sourceIndexPath.section,sourceIndexPath.row, proposedDestinationIndexPath.section,proposedDestinationIndexPath.row );
    
    
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
    
    DLog(@"updateHeaderViewForSection:%d", section);
    
    UIView *view = [self updatedHeaderViewForSection:section];
    
    [view setNeedsDisplay];
}

-(HeaderView *) updatedHeaderViewForSection:(NSInteger) section{
    HeaderView *headerView = self.headerViews[section];
    
    [headerView setText:[self.delegate TimetableViewControllerDelegate_daySummary:section]];
    
    NSInteger total = 0;
    for(Slot *slot in self.currentWeek[section] ){
        total += slot.duration;
    }
    if(total > 100) [headerView setWarning:YES];
    else
        [headerView setWarning:NO];
    
    return headerView;
}


-(void) reloadTable{
    [self.tableView reloadData];
}


-(void) changeCurrentWeekAnimatedTo:(NSInteger) weekIndex{
  
    [self.tableView beginUpdates];
    
    [self deleteAllRows:UITableViewRowAnimationFade];
    
    [self.delegate TimetableViewControllerDelegate_setWeekIndex:weekIndex];
    
    [self addAllRows:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    [self updateAllHeaders];
    
    self.title = [NSString stringWithFormat:@"Week %d", weekIndex+1];

}


@end
