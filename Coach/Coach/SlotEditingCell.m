#import "SlotEditingCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"
#import "SimpleHScroller.h"

@interface SlotEditingCell ()
@property (nonatomic, strong) IconSelectionView *activitiesIconSelectionView;
@property (nonatomic, strong) SimpleHScroller *simpleHScroller;
@property (nonatomic, weak) id<SlotEditingCellDelegate> delegate;


@property NSInteger duration;
@property TActivityType activityType;

@end

@implementation SlotEditingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotEditingCellDelegate>) delegate
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.delegate = delegate;
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        
        for(NSNumber *number in [self activityTypeOrdering]){
            [imageArray addObject:[UIImage imageForActivityType:number.integerValue]];
        }
        
        self.activitiesIconSelectionView = [[IconSelectionView alloc] initWithPoint:CGPointMake(0,40)
                                                                             images:imageArray
                                                                           iconSize:CGSizeMake(50,50)
                                                                            padding:5
                                                                           delegate:self];
        
        NSMutableArray *scrollerArray = [[NSMutableArray alloc] init];
        
        for(NSInteger i = 1 ; i <= 80 ; i++){
            [scrollerArray addObject:[NSString niceStringFromDuration:i*15]];
        }
        
        self.simpleHScroller = [[SimpleHScroller alloc] initWithPoint:CGPointMake(5,103) items:scrollerArray delegate:self];
        
        
        UIImageView *upImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up.png"]];
        
        upImageView.frame = CGRectMake(100,0,50,50);
        
        
        [self.contentView addSubview:upImageView];
        
        
        [self.contentView addSubview:self.simpleHScroller];
        [self.contentView addSubview:self.activitiesIconSelectionView];

    }
    return self;
}

-(void) setupWithDuration:(NSInteger)duration activityType:(TActivityType)activityType{
    [self.activitiesIconSelectionView setupWithSelectedIndex:activityType];
    [self.simpleHScroller setupWithDuration:duration];
}

-(NSArray*) activityTypeOrdering{
    return [NSArray arrayWithObjects:[NSNumber numberWithInteger:EActivityTypeSwim], [NSNumber numberWithInteger:EActivityTypeBike],[NSNumber numberWithInteger:EActivityTypeRun], [NSNumber numberWithInteger:EActivityTypeStrengthAndConditioning],nil];
    
}

-(NSInteger) indexForActivityType:(TActivityType) activityType{
    for(NSInteger index = 0 ; index <  [self activityTypeOrdering].count ; index++){
        NSNumber *number = [self activityTypeOrdering][index];
        if(number.integerValue == activityType){
            return index;
        }
    }
    
    return 0;
}

-(TActivityType) activityTpeForIndex:(NSInteger) index{
    NSNumber *number = [self activityTypeOrdering][index];
    return number.integerValue;
}

-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex{
    [self.delegate SlotEditingCellDelegate_activityTypeChanged:[self activityTpeForIndex:iconIndex]];
}

-(void) SimpleHScrollerDelegate_durationChanged:(NSInteger) duration{
    [self.delegate SlotEditingCellDelegate_durationChanged:duration];
    
}

@end