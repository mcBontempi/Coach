#import "SlotCell.h"
#import "UIImage_ImageForActivityType.h"
#import "NSString_NiceStringFromDuration.h"
#import "CheckboxButton.h"

@interface SlotCell ()
@property (nonatomic, strong) UIImageView *activityTypeImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *tagsTextField;
@property (nonatomic, strong) UITextField *athleteNotesTextField;
@property (nonatomic, strong) UITextField *coachNotesTextField;
@property (nonatomic, strong) CheckboxButton *checkbox;
@property (nonatomic, weak) id<SlotCellDelegate> delegate;

@property NSInteger duration;
@property TActivityType activityType;
@property (nonatomic, strong) NSString *tags;
@property (nonatomic, strong) NSString *athleteNotes;
@property (nonatomic, strong) NSString *coachNotes;

@end

@implementation SlotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id<SlotCellDelegate>) delegate
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.delegate = delegate;
    
    self.activityTypeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.label.textColor = [UIColor darkGrayColor];
    self.label.font=[UIFont fontWithName:@"Trebuchet MS" size:22.0];
    self.label.backgroundColor = [UIColor whiteColor];
    
    self.tagsTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.tagsTextField.textColor = [UIColor grayColor];
    self.tagsTextField.font=[UIFont fontWithName:@"Trebuchet MS" size:14.0];
    self.tagsTextField.backgroundColor = [UIColor whiteColor];
    self.tagsTextField.userInteractionEnabled = NO;

    
    self.athleteNotesTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.athleteNotesTextField.textColor = [UIColor grayColor];
    self.athleteNotesTextField.font=[UIFont fontWithName:@"Trebuchet MS" size:12.0];
    self.athleteNotesTextField.backgroundColor = [UIColor whiteColor];
    self.athleteNotesTextField.userInteractionEnabled = NO;

    
    
    
    self.checkbox = [[CheckboxButton alloc] initWithFrame:CGRectZero];
    
    [self.contentView addSubview:self.activityTypeImageView];
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.tagsTextField];
    [self.contentView addSubview:self.athleteNotesTextField];
    [self.contentView addSubview:self.coachNotesTextField];
    [self.contentView addSubview:self.checkbox];
  }
  return self;
}


-(void) setupWithChecked:(BOOL) checked duration:(NSInteger)duration activityType:(TActivityType) activityType tags:(NSString *)tags athleteNotes:(NSString *)athleteNotes coachNotes:(NSString *)coachNotes
{
  self.checkbox.selected = checked;
  self.activityType = activityType;
  self.duration = duration;
  self.athleteNotes = athleteNotes;
  self.coachNotes = coachNotes;
  self.tags = tags;
}


-(void) layoutSubviews{
  [super layoutSubviews];
  
  CGRect frame = self.frame;
  
  const CGFloat checkboxWidth = 50;
  const CGFloat checkboxHeight = 50;
  const CGFloat checkboxPadding = 0;
  
  const CGFloat labelHeight = 25;
  const CGFloat labelYPadding = 2;
  const CGFloat iconPadding = 5;
  const CGFloat textPadding = 5;
  const CGFloat iconHeight = 41;
  const CGFloat textFieldVertPadding = 0;
  const CGFloat tagHeight = 20;
  
  const CGFloat athleteNotesPadding = 3;
  const CGFloat coachNotesPadding = 3;
  
  self.activityTypeImageView.image = [UIImage imageForActivityType:self.activityType];
  self.activityTypeImageView.frame = CGRectMake(iconPadding,iconPadding, iconHeight, iconHeight);
  
  CGFloat labelOffsetX = iconPadding + self.activityTypeImageView.frame.origin.x + self.activityTypeImageView.frame.size.width + textPadding;

  CGFloat labelWidth = self.contentView.frame.size.width - labelOffsetX - (textPadding *2) - checkboxWidth;
  
  self.label.frame = CGRectMake(labelOffsetX,labelYPadding,labelWidth, labelHeight);
  self.label.text = [NSString niceStringFromDuration:self.duration];
  
  self.tagsTextField.frame = CGRectMake(labelOffsetX, CGRectGetMaxY(self.label.frame) + textFieldVertPadding, labelWidth, tagHeight);
  self.tagsTextField.text = self.tags;
  
  
  CGSize size = [self.athleteNotesTextField.text sizeWithFont:self.athleteNotesTextField.font forWidth:KNoteFieldWidth lineBreakMode:NSLineBreakByWordWrapping ];
  
  self.athleteNotesTextField.frame = CGRectMake(labelOffsetX, CGRectGetMaxY(self.tagsTextField.frame) + textFieldVertPadding, size.width, size.height);
  self.athleteNotesTextField.text = self.athleteNotes;
  
  
  
  
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