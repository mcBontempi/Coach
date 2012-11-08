#import "TimetableViewController.h"
#import "Slot.h"
#import "DataUtil.h"
#import "Utils.h"
#import "HeaderView.h"

@interface TimetableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *headerViews;
@property NSInteger lastSectionUpdatedWhenDragging;
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
        
    }
    
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    [self setRightBarButtonEdit];
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

-(void)toggleEditPressed{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if(self.tableView.editing){
        // go into edit mode
        [self setRightBarButtonDone];
        [self.navigationItem setHidesBackButton:YES animated:YES];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                               target:self
                                                                                               action:@selector(cancelItemPressed)] animated:YES];
        
        [self.delegate TimetableViewControllerDelegate_startEditingWeek];
    }
    else{
        // editing done
        [self setRightBarButtonEdit];
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        [self.navigationItem setHidesBackButton:NO animated:YES];
        
        [self.delegate TimetableViewControllerDelegate_commitEditingWeek];
    }
}

-(void) cancelItemPressed{
    // We dont want a deep copy here, as we need to pointer check the slots later.
    NSMutableArray *weekBeforeCancel = [[NSMutableArray alloc] init];
    for(id day in self.currentWeek){
        id newDay = [[NSMutableArray alloc] init];
        [weekBeforeCancel addObject:newDay];
        for(id slot in day){
            [newDay addObject:slot];
        }
    }
    
    [self.delegate TimetableViewControllerDelegate_cancelEditingWeek];
    [self animateWeekFrom:weekBeforeCancel To:self.currentWeek];
    // editing done
    [self setRightBarButtonEdit];
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    [self.navigationItem setHidesBackButton:NO animated:YES];
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

-(NSIndexPath*) findSlot:(Slot*) slotFind inWeek:(NSArray*) week{
    for(NSInteger dayIndex = 0 ; dayIndex < week.count ; dayIndex++){
        NSMutableArray *day = week[dayIndex];
        for(NSInteger slotIndex = 0 ; slotIndex < day.count ; slotIndex++){
            Slot *slot = day[slotIndex];
            if([slot.uid isEqualToString:slotFind.uid]){
                return [NSIndexPath indexPathForRow:slotIndex  inSection:dayIndex];
            }
        }
    }
    return nil;
}

-(void) animateWeekFrom:(NSArray*)from To:(NSArray*)to{
    
    [self.tableView beginUpdates];
    for(NSInteger fromDayIndex = 0 ; fromDayIndex < from.count ; fromDayIndex++){
        NSMutableArray *fromDay = from[fromDayIndex];
        
        for(NSInteger fromSlotIndex = 0 ; fromSlotIndex < fromDay.count ; fromSlotIndex++){
            Slot *slot = fromDay[fromSlotIndex];
            NSIndexPath *foundIndexPath = [self findSlot:slot inWeek:to];
            
            if(foundIndexPath){
                if(fromDayIndex != foundIndexPath.section){
                    
                    NSLog(@"%d %d", fromDayIndex, fromSlotIndex);
                    NSLog(@"%d %d", foundIndexPath.section, foundIndexPath.row);
                    
                    [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:fromDayIndex inSection:fromSlotIndex] toIndexPath:foundIndexPath ];
                }
            }
        }
    }
    [self.tableView endUpdates];
}

-(void) addItemPressed{
    
    [self.delegate TimetableViewControllerDelegate_addItem];
    
    NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [self.tableView insertRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    
    [self updateHeaderViewForSection:0];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    NSArray* slots = self.currentWeek[indexPath.section];
    
    Slot *slot = slots[indexPath.row];
    
    UIColor *color = [UIColor whiteColor];// [DataUtil fillUIColorOfActivityType:slot.activityType];
    
    cell.backgroundColor = color;
    cell.textLabel.text = [NSString stringWithFormat:@"%d", slot.duration];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
    NSArray* slots = self.currentWeek[indexPath.section];
    
    Slot *slot = slots[indexPath.row];
    
    return slot.duration > 50 ? slot.duration : 50;
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.delegate TimetableViewControllerDelegate_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    [self updateHeaderViewForSection:destinationIndexPath.section];
    [self updateHeaderViewForSection:sourceIndexPath.section];
    
    self.lastSectionUpdatedWhenDragging = -1;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    [self.delegate TimetableViewControllerDelegate_moveRowAtIndexPath:sourceIndexPath toIndexPath:proposedDestinationIndexPath];
    
    DLog(@"from section %d row %d to section %d row %d", sourceIndexPath.section, sourceIndexPath.row, proposedDestinationIndexPath.section, proposedDestinationIndexPath.row);
    
    DLog(@"proposed section = %d", self.lastSectionUpdatedWhenDragging);
    
    
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
    
    return 40;
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


@end
