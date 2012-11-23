#import "ListViewController.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@end


@protocol CHStaticDemoDelegate <NSObject>

// method to inform slidecontroller that something has been selected
-(void)staticDemoDidSelectText:(NSString *)text;

@end


@implementation ListViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<ListViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"ListViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"ListViewController_iPad" bundle:nil];
    }
    if(self){
        self.delegate = delegate;
        
        self.navigationItem.title = @"";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setNavigationBar:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return [self.delegate ListViewControllerDelegate_actionItemCount];
    }
    else {
        return [self.delegate ListViewControllerDelegate_numberOfWeeks];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Foobar"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Foobar"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.textLabel.backgroundColor = [UIColor darkGrayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.contentView.backgroundColor = [UIColor darkGrayColor];
    
    if(indexPath.section == 0){
        cell.textLabel.text = [self.delegate ListViewControllerDelegate_actionItem:indexPath.row];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"Week %d", indexPath.row+1];
    }
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        [self.delegate ListViewControllerDelegate_actionItemPressed:indexPath.row];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        [self.delegate ListViewControllerDelegate_showWeek:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section)
        return 5;
    else return 0; 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header =  [[UIView alloc] initWithFrame:CGRectMake(0,0,320,5)];

    header.backgroundColor = [UIColor blackColor];
    
    return header;
}

-(void) ToListViewControllerDelegate_highlightCurrentWeek:(NSInteger) weekIndex{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:weekIndex inSection:1] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}




@end
