#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"
#import "CheckboxButton.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CheckboxButton *checkbox;
@property (nonatomic, weak) id<SlotCellDelegate> delegate;

@property NSInteger duration;
@property TActivityType activityType;

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
        self.label.backgroundColor = [UIColor whiteColor];
        
        self.checkbox = [[CheckboxButton alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.activityTypeImageView];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.checkbox];
    }
    return self;
}


-(void) setupWithChecked:(BOOL) checked duration:(NSInteger)duration activityType:(TActivityType) activityType{
    self.checkbox.selected = checked;
    self.activityType = activityType;
    self.duration = duration;
}


-(void) layoutSubviews{
    [super layoutSubviews];

    CGRect frame = self.frame;
    
    const CGFloat checkboxWidth = 50;
    const CGFloat checkboxHeight = 50;
    const CGFloat checkboxPadding = 0;
    
    const CGFloat iconPadding = 5;
    const CGFloat textPadding = 5;
    
    CGFloat size = frame.size.height - (iconPadding *2);
    
    self.activityTypeImageView.image = [UIImage imageForActivityType:self.activityType];
    self.activityTypeImageView.frame = CGRectMake(iconPadding,iconPadding, size, size);
    
    CGFloat labelOffsetX = (iconPadding*2) + size + textPadding;
    CGFloat textHeight = frame.size.height - (textPadding *2);
    
    self.label.frame = CGRectMake(labelOffsetX,textPadding,self.contentView.frame.size.width - labelOffsetX - (textPadding *2) - checkboxWidth, textHeight);
    self.label.text = [NSString niceStringFromDuration:self.duration];
    
    self.checkbox.frame = CGRectMake(self.label.frame.origin.x + self.label.frame.size.width+ checkboxPadding, checkboxPadding, checkboxWidth, checkboxHeight);
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.checkbox addTarget:self action:@selector(checked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void) checked:(id) sender{
    if(sender == self.checkbox){
        [self.delegate SlotCellDelegate_checked:self.checkbox.selected identifier:self];
    }
}

-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    self.checkbox.hidden = editing;
}


@end