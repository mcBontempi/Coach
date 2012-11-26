#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"
#import "IconSelectionView.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftRecognizer;
@property (nonatomic, strong) IconSelectionView *activitiesIconSelectionView;

@end

@implementation SlotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.activityTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.textColor = [UIColor blackColor];
        self.label.font=[UIFont fontWithName:@"Trebuchet MS" size:18.0];
        self.label.backgroundColor = [UIColor clearColor];
        
        NSInteger selectedIndex = 2;
        
        self.activitiesIconSelectionView = [[IconSelectionView alloc] initWithFrame:CGRectZero andImages:[NSArray arrayWithObjects:
                                                                                                          [UIImage imageForActivityType:EActivityTypeSwim],
                                                                                                          [UIImage imageForActivityType:EActivityTypeBike],
                                                                                                          [UIImage imageForActivityType:EActivityTypeRun],nil
                                                                                                          ] iconSize:CGSizeMake(30,30) padding:5 selectedIndex:selectedIndex];
        
        [self.contentView addSubview:self.activitiesIconSelectionView];
        self.activitiesIconSelectionView.alpha = 0.0;
        [self.contentView addSubview:self.activityTypeImageView];
        [self.contentView addSubview:self.label];
    }
    return self;
}


-(void)reload{
}

-(void) setHeight:(CGFloat) height{
    
    if(self.cellExpandedForEditing){
        self.activityTypeImageView.alpha = 0.0;
        self.activitiesIconSelectionView.alpha = 1.0;
        self.backgroundColor = [UIColor lightGrayColor];
        self.label.alpha = 0.0;
    }
    else{
        self.label.frame = CGRectZero;
        self.activityTypeImageView.alpha = 1.0;
        self.activitiesIconSelectionView.alpha = 0.0;
        
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
    }
}

@end
