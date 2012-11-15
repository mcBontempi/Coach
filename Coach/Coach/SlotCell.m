#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@end

@implementation SlotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.activityTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.activityTypeImageView];
    }
    return self;
}

-(void)reload{
}

-(void) setHeight:(CGFloat) height{
    const CGFloat iconPadding = 5;
    
    CGFloat size = height - (iconPadding *2);
    
    self.activityTypeImageView.image = [UIImage imageForActivityType:self.activityType];
    self.activityTypeImageView.frame = CGRectMake(iconPadding,iconPadding, size, size);
}

@end
