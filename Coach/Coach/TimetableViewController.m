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
    [self.tableView setEditing:YES animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger sectionCount = [self.delegate.days count];
    
    NSLog(@"%d", sectionCount);
    
    return sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rowCount = [self.delegate.days[section] count];
    
    NSLog(@"%d", rowCount);
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.textLabel.textColor = [UIColor blueColor];
    }
    
    NSArray* slots = self.delegate.days[indexPath.section];
    
    Slot *slot = slots[indexPath.row];
    
    UIColor *color = [DataUtil fillUIColorOfActivityType:slot.activityType];
    
 
    
    color = [Utils lighterColorForColor:color];
    
    color = [Utils lighterColorForColor:color];
    color = [Utils lighterColorForColor:color];
    
       cell.backgroundColor = color;
    cell.textLabel.text = [NSString stringWithFormat:@"%d", slot.duration];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}







@end
