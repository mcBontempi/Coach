#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"
#import "SimpleHScroller.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, strong) IconSelectionView *activitiesIconSelectionView;

@property (nonatomic, strong) SimpleHScroller *simpleHScroller;

@property (nonatomic, weak) id<SlotCellDelegate> delegate;

@end

@implementation SlotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.delegate = delegate;
        
        self.activityTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.textColor = [UIColor blackColor];
        self.label.font=[UIFont fontWithName:@"Trebuchet MS" size:18.0];
        self.label.backgroundColor = [UIColor clearColor];
        
        
        NSInteger selectedIndex = 2;
        
        
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        
        for(NSNumber *number in [self activityTypeOrdering]){
            [imageArray addObject:[UIImage imageForActivityType:number.integerValue]];
        }
        
        
        
        self.activitiesIconSelectionView = [[IconSelectionView alloc] initWithFrame:CGRectZero andImages:imageArray
                                                                           iconSize:CGSizeMake(40,40)
                                                                            padding:5
                                                                      selectedIndex:selectedIndex
                                                                           delegate:self];
        self.activitiesIconSelectionView.alpha = 0.0;
        
        NSMutableArray *scrollerArray = [[NSMutableArray alloc] init];
        
        for(NSInteger i = 1 ; i <= 80 ; i++){
            [scrollerArray addObject:[NSString niceStringFromDuration:i*15]];
        }
        
        self.simpleHScroller = [[SimpleHScroller alloc] initWithFrame:CGRectZero items:scrollerArray];
        
        [self.contentView addSubview:self.simpleHScroller];
        [self.contentView addSubview:self.activitiesIconSelectionView];
        [self.contentView addSubview:self.activityTypeImageView];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(NSArray*) activityTypeOrdering{
    return [NSArray arrayWithObjects:[NSNumber numberWithInteger:EActivityTypeSwim], [NSNumber numberWithInteger:EActivityTypeBike],[NSNumber numberWithInteger:EActivityTypeRun],nil];
    
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


-(void)reload{
}

-(void) setHeight:(CGFloat) height{
    const CGFloat iconPadding = 5;
    const CGFloat textPadding = 5;
    
    CGFloat size = height - (iconPadding *2);
    
    self.activityTypeImageView.image = [UIImage imageForActivityType:self.activityType];
    self.activityTypeImageView.frame = CGRectMake(iconPadding,iconPadding, size, size);
    
    CGFloat labelOffsetX = (iconPadding*2) + size + textPadding;
    CGFloat textHeight = height - (textPadding *2);
    
    self.label.frame = CGRectMake(labelOffsetX,textPadding,self.contentView.frame.size.width - labelOffsetX - (textPadding *2), textHeight);
    self.label.text = [NSString niceStringFromDuration:self.duration];
    
    self.backgroundColor = [UIColor whiteColor];
    
    const CGFloat hScrollerHeight = 30;
    
    self.simpleHScroller.frame = CGRectMake(iconPadding, (iconPadding*3) + height, 200, hScrollerHeight );
    
    
    if(self.cellExpandedForEditing){
        self.activityTypeImageView.alpha = 0.0;
        self.activitiesIconSelectionView.alpha = 1.0;
        self.backgroundColor = [UIColor whiteColor];
        self.label.alpha = 0.0;
        self.simpleHScroller.alpha = 1.0;
    }
    else{
        self.activityTypeImageView.alpha = 1.0;
        self.activitiesIconSelectionView.alpha = 0.0;
        
        self.label.alpha = 1.0;
        
        
        self.simpleHScroller.alpha = 0.0;
        
    }
}


-(void) IconSelectionViewDelegate_iconSelected:(NSInteger) iconIndex{
    [self.delegate SlotCellDelegate_activityTypeChanged:[self activityTpeForIndex:iconIndex]];
}

@end