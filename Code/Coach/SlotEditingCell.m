#import "SlotEditingCell.h"
#import "UIImage_ImageForActivityType.h"
#import "UIImage_ImageForZone.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"
#import "SimpleHScroller.h"
#import "MultipleIconSelectionView.h"

@interface SlotEditingCell ()
@property (nonatomic, strong) IconSelectionView *activitiesIconSelectionView;
@property (nonatomic, strong) SimpleHScroller *simpleHScroller;
@property (nonatomic, weak) id<SlotEditingCellDelegate> delegate;
@property (nonatomic, strong) MultipleIconSelectionView *zonesMultipleIconSelectionView;


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
        
        // image showing contraction of cell
        UIImageView *upImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"up.png"]];
        upImageView.frame = CGRectMake(100,0,50,50);
        
        
        
        // activities selection
        NSMutableArray *activityImageArray = [[NSMutableArray alloc] init];
        
        for(NSNumber *number in [self activityTypeOrdering]){
            [activityImageArray addObject:[UIImage imageForActivityType:number.integerValue]];
        }
        
        self.activitiesIconSelectionView = [[IconSelectionView alloc] initWithPoint:CGPointMake(0,40)
                                                                             images:activityImageArray
                                                                           iconSize:CGSizeMake(50,50)
                                                                            padding:5
                                                                           delegate:self];
        
        
        
        
        NSMutableArray *zoneImageArray = [[NSMutableArray alloc] init];
        
        for(NSNumber *number in [self zoneOrdering]){
            [zoneImageArray addObject:[UIImage imageForZone:number.integerValue]];
        }
        
        // zone selection
        self.zonesMultipleIconSelectionView = [[MultipleIconSelectionView alloc] initWithPoint:CGPointMake(0,103)
                                                                                        images:zoneImageArray
                                                                                      iconSize:CGSizeMake(30,30)
                                                                                       padding:5
                                                                                      delegate:self];
        
        
        
        // duration selection
        NSMutableArray *scrollerArray = [[NSMutableArray alloc] init];
        
        for(NSInteger i = 1 ; i <= 80 ; i++){
            [scrollerArray addObject:[NSString niceStringFromDuration:i*15]];
        }
        
        self.simpleHScroller = [[SimpleHScroller alloc] initWithPoint:CGPointMake(5,150) items:scrollerArray delegate:self];
        
        [self.contentView addSubview:upImageView];
        [self.contentView addSubview:self.activitiesIconSelectionView];
        [self.contentView addSubview:self.zonesMultipleIconSelectionView];
        [self.contentView addSubview:self.simpleHScroller];
        
    }
    return self;
}

-(void) setupWithDuration:(NSInteger)duration activityType:(TActivityType)activityType zone:(TZone) zone{
    
    [self.activitiesIconSelectionView setupWithSelectedIndex:activityType];
    
    [self.zonesMultipleIconSelectionView setupWithSelectedIndexes:[self selectedIndexesForZone:zone]];
    
    [self.simpleHScroller setupWithDuration:duration];
}

// activity Type conversion methods

-(NSArray*) activityTypeOrdering{
    return @[@(EActivityTypeSwim), @(EActivityTypeBike), @(EActivityTypeRun), @(EActivityTypeStrengthAndConditioning)];
}

-(NSArray*) zoneOrdering{
    return @[@(EZone1), @(EZone2), @(EZone3), @(EZone4), @(EZone5)];
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

// zone conversion methods

-(TZone) zoneForSelectedIndexes:(NSArray*) array{
    
    NSInteger zone = 0;
    
    for(NSNumber *number in array){
        
        switch (number.integerValue)
        {
            case 0: zone += EZone1; break;
            case 1: zone += EZone2; break;
            case 2: zone += EZone3; break;
            case 3: zone += EZone4; break;
            case 4: zone += EZone5; break;
        }
    }
    
    return zone;
}

-(NSArray*) selectedIndexesForZone:(TZone) zone{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    if(zone & EZone1) [array addObject:[NSNumber numberWithInteger:0]];
    if(zone & EZone2) [array addObject:[NSNumber numberWithInteger:1]];
    if(zone & EZone3) [array addObject:[NSNumber numberWithInteger:2]];
    if(zone & EZone4) [array addObject:[NSNumber numberWithInteger:3]];
    if(zone & EZone5) [array addObject:[NSNumber numberWithInteger:4]];
    
    return array;
}


-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex{
    [self.delegate SlotEditingCellDelegate_activityTypeChanged:[self activityTpeForIndex:iconIndex]];
}

-(void) MultipleIconSelectionViewDelegate_iconsSelected:(NSArray*) iconIndexArray{
    
    [self.delegate SlotEditingCellDelegate_zoneChanged:[self zoneForSelectedIndexes:iconIndexArray]];
}

-(void) SimpleHScrollerDelegate_durationChanged:(NSInteger) duration{
    [self.delegate SlotEditingCellDelegate_durationChanged:duration];
    
}
@end