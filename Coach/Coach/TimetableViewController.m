#import "TimetableViewController.h"
#import "Slot.h"
#import "DataUtil.h"
#import "Utils.h"
#import "HeaderView.h"
#import "SlotCell.h"
#import "SlotEditingCell.h"

const CGFloat KSlotCellHeight = 40;
const CGFloat KExpandedSlotHeight = 100;

@interface TimetableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *headerViews;
@property NSInteger lastSectionUpdatedWhenDragging;
@property (nonatomic, strong) Slot *slotBeingEdited;
@property (nonatomic, strong) UIBarButtonItem *previousBarButtonItem;
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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) {
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }
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
        
        self.slotBeingEdited = nil;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
        
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
    
    self.slotBeingEdited = nil;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    
    
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
    
    return rowCount;
}

-(Slot*) slotForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSArray* slots = self.currentWeek[indexPath.section];
    if(indexPath.row >= slots.count) return nil;
    Slot *slot = slots[indexPath.row];
    
    return slot;
}

-(NSIndexPath*) indexPathForSlot:(Slot*) slot{
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
        
        NSLog(@"section = %d : row = %d", indexPath.section, indexPath.row);
        BOOL cellExpandedForEditing = self.slotBeingEdited == [self slotForRowAtIndexPath:indexPath];
        NSLog(@"cell expanded = %d", cellExpandedForEditing);
        

        
        
        if(cellExpandedForEditing){
            
            // this is a slot row
            SlotEditingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SlotEditing"];
            if (cell == nil) {
                cell = [[SlotEditingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SlotEditing" delegate:self];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [UIColor blueColor];
      
            }
          
            Slot *slot = [self slotForRowAtIndexPath:indexPath];
            cell.duration = slot.duration;
            cell.activityType = slot.activityType;
            
            return cell;;
        }
        else{
            // this is a slot row
            SlotCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Slot"];
            if (cell == nil) {
                cell = [[SlotCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Slot"];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = [UIColor blueColor];
                UIColor *color = [UIColor whiteColor];
                cell.backgroundColor = color;
            }
            
            Slot *slot = [self slotForRowAtIndexPath:indexPath];
            cell.duration = slot.duration;
            cell.activityType = slot.activityType;
            
            
            return cell;
            
        }
    
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([self slotForRowAtIndexPath:indexPath] && self.slotBeingEdited == [self slotForRowAtIndexPath:indexPath])
		return KExpandedSlotHeight;
    else
        return KSlotCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray* slots = self.currentWeek[indexPath.section];
    
    if(indexPath.row >= slots.count){
        return;
    }
    
    // take a temp here so we do a proper redraw in cellforrowatindexpath;
    Slot *tempSlot = self.slotBeingEdited;
    self.slotBeingEdited = nil;
 
    [self.tableView beginUpdates];
    
    if(tempSlot)
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[self indexPathForSlot:tempSlot]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
        if(!(tempSlot && tempSlot== [self slotForRowAtIndexPath:indexPath])){
        self.slotBeingEdited= [self slotForRowAtIndexPath:indexPath];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
}

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


-(void) ToTimetableViewControllerDelegate_changeCurrentWeekAnimatedTo:(NSInteger) weekIndex{
    
    [self.tableView beginUpdates];
    
    [self deleteAllRows:UITableViewRowAnimationFade];
    
    [self.delegate TimetableViewControllerDelegate_setWeekIndex:weekIndex];
    
    [self addAllRows:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    [self updateAllHeaders];
    
    self.title = [NSString stringWithFormat:@"Week %d", weekIndex+1];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}





-(void) SlotCellDelegate_activityTypeChanged:(TActivityType) activityType{

    
    [self.delegate TimetableViewControllerDelegate_activityTypeChanged:(TActivityType) activityType slot:self.slotBeingEdited];
}





@end
