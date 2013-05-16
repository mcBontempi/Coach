#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *textLabel1;
@property (nonatomic, strong) UILabel *textLabel2;
@property (nonatomic, strong) UILabel *currentLabel;

@end

const CGFloat paddingForWarning = 5;

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    CGFloat leftTextPadding = 65;
    
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_cell_background.png"]];
    self.backgroundImageView.alpha = 0.9;
    [self addSubview:self.backgroundImageView];
    
    self.textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(leftTextPadding,-2,frame.size.width,frame.size.height)];
    [self addSubview:self.textLabel1];
    
    self.textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(leftTextPadding,-2,frame.size.width,frame.size.height)];
    [self addSubview:self.textLabel2];
    
    
    
    
    self.currentLabel = self.textLabel1;
    
    self.textLabel1.backgroundColor = [UIColor clearColor];
    self.textLabel2.backgroundColor = [UIColor clearColor];
    
    self.textLabel1.textColor = [UIColor whiteColor];
    self.textLabel2.textColor = [UIColor whiteColor];
    
    self.textLabel1.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    self.textLabel2.font=[UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    
    self.clipsToBounds = YES;
    
  }
  return self;
}


-(void) layoutSubviews{
  [super layoutSubviews];
  
  
}

-(void) animateIn:(UILabel *) label{
  
  [UIView animateWithDuration:0.2 animations:^{
    label.alpha = 1.0;
    CGRect frame = label.frame;
    label.frame = frame;
  }];
}
-(void) animateOut:(UILabel *) label{
  [UIView animateWithDuration:0.2 animations:^{
    label.alpha = 0.0;
    CGRect frame = label.frame;
    label.frame = frame;
  }];
}

-(void) setText:(NSString *) text{
  if(![text isEqualToString:self.currentLabel.text]){
    if(self.currentLabel == self.textLabel1){
      [self animateOut:self.textLabel1];
      self.textLabel2.text = text;
      [self animateIn:self.textLabel2];
      
      self.currentLabel = self.textLabel2;
    }
    else{
      [self animateOut:self.textLabel2];
      self.textLabel1.text = text;
      [self animateIn:self.textLabel1];
      
      self.currentLabel = self.textLabel1;
    }
  }
}

@end
