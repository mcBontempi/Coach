#import "TimetableViewController.h"
#import "Slot.h"
#import "DataUtil.h"
#import "Utils.h"

@interface TimetableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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
    }
    
    return self;
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView setEditing:YES animated:NO];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger sectionCount = [self.delegate.currentWeek count];
    
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowCount = [self.delegate.currentWeek[section] count];
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    NSArray* slots = self.delegate.currentWeek[indexPath.section];
    
    Slot *slot = slots[indexPath.row];
    
    UIColor *color = [DataUtil fillUIColorOfActivityType:slot.activityType];
    
    cell.backgroundColor = color;
    cell.textLabel.text = [NSString stringWithFormat:@"%d", slot.duration];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray* slots = self.delegate.currentWeek[indexPath.section];
    
    Slot *slot = slots[indexPath.row];
    
    return slot.duration > 50 ? slot.duration : 50;
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    [self.delegate moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,40)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,40)];
    
    label.text = [DataUtil weekdayFromWeekdayOrdinal:section];
    
    [view addSubview:label];
    
    return view;
}


-(void) reloadTable{
    [self.tableView reloadData];
}


-(void) insertRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView endUpdates];
}

-(void) removeRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}






@end
