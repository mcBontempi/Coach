#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@property (nonatomic, strong) UILabel *label;
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
        
        [self.contentView addSubview:self.activityTypeImageView];
        [self.contentView addSubview:self.label];
        
        
        
    }
    return self;
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
    
}

@end
