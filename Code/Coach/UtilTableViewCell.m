#import "UtilTableViewCell.h"

@implementation UtilTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
      self.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
      
      self.textLabel.textColor = [UIColor darkGrayColor];
      
      _spot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"spot.png"]];
 
      [self.contentView addSubview:_spot];
      
      self.selectionStyle = UITableViewCellSelectionStyleNone;
  
    }
    return self;
}

- (void) layoutSubviews
{
  [super layoutSubviews];
  CGRect frame = self.textLabel.frame;
  frame.origin.x = 40;
  self.textLabel.frame = frame;
  
  _spot.frame = CGRectMake(10, 14 , 18, 17 );
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

  self.spot.hidden = !selected;
}

- (void)setup
{
  
  
}

@end
