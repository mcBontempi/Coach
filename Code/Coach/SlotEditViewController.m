#import "SlotEditViewController.h"

@implementation SlotEditViewController

-(id) init{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    self = [super initWithNibName:@"SlotEditViewController_iPhone" bundle:nil];
  } else {
    self = [super initWithNibName:@"SlotEditViewController_iPad" bundle:nil];
  }
  
  return self;
}



@end
