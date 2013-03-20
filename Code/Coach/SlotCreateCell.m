#import "SlotCreateCell.h"
#import "UIImage_ImageForActivityType.h"
#import "IconSelectionView.h"
#import "SimpleHScrollerDelegate.h"

@interface SlotCreateCell ()
@property (nonatomic, strong) IconSelectionView *activitiesIconSelectionView;
@property (nonatomic, weak) id<SlotCreateCellDelegate> delegate;
@property TActivityType activityType;
@end

@implementation SlotCreateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCreateCellDelegate>) delegate
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.delegate = delegate;
    
    // activities selection
    NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
    
    for(NSNumber *number in [self activityTypeOrdering]){
      [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
    }
    
    self.activitiesIconSelectionView = [[IconSelectionView alloc] initWithPoint:CGPointMake(0,00)
                                                                         images:activityImageArray
                                                                       iconSize:CGSizeMake(40,40)
                                                                        padding:5
                                                                       delegate:self];
    
    
    [self.contentView addSubview:self.activitiesIconSelectionView];
    
  }
  return self;
}

-(void) setup
{
  [self.activitiesIconSelectionView setSelectedIndex:-1];
}

-(NSArray*) activityTypeOrdering
{
  return @[@(EActivityTypeSwim), @(EActivityTypeBike), @(EActivityTypeRun), @(EActivityTypeStrengthAndConditioning)];
}

-(NSInteger) indexForActivityType:(TActivityType) activityType
{
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

-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex
{
  [self.delegate SlotCreateCellDelegate_activityTypeChanged:[self activityTpeForIndex:iconIndex]];
}

@end