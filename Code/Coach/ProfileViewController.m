#import "ProfileViewController.h"
#import "ProfileGraph.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet ProfileGraph *profileGraph;

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.profileGraph.profile = self.profile;
}

@end
