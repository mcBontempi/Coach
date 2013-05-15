//
//  ListViewCell.m
//  Coach
//
//  Created by daren taylor on 22/04/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import "ListViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ListViewCell{
  
  UILabel *_weekLabel;
  UILabel *_weekSummaryLabel;
  UILabel *_weekPercentCompletedLabel;
  
  UIImageView *_weekCountCircleImageView;
  
  NSInteger _weekPercentCompleted;
  
  UIImageView *_weekCompletedCircleImageView;
}

- (void)applySoftShadowToLabel:(UILabel *)label
{
  label.layer.shadowOpacity = 1.0;
  label.layer.shadowRadius = 3.0;
  label.layer.shadowColor = [UIColor blackColor].CGColor;
  label.layer.shadowOffset = CGSizeMake(0.0, 3.0);
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _weekLabel.font=[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:20.0];
    _weekLabel.backgroundColor = [UIColor clearColor];
    _weekLabel.textAlignment = NSTextAlignmentCenter;
    
    _weekSummaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _weekSummaryLabel.font=[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:16.0];
    _weekSummaryLabel.backgroundColor = [UIColor clearColor];
    _weekSummaryLabel.numberOfLines = 2;
    [self applySoftShadowToLabel:_weekSummaryLabel];
    
    _weekPercentCompletedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _weekPercentCompletedLabel.textColor = [UIColor grayColor];
    _weekPercentCompletedLabel.font=[UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:18.0];
    _weekPercentCompletedLabel.backgroundColor = [UIColor clearColor];
    _weekPercentCompletedLabel.textAlignment = NSTextAlignmentCenter;
    
    _weekCountCircleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_cell_week_count_circle.png"]];
    
    _weekCompletedCircleImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"list_cell_week_completed_circle.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,21,0,21) ]];
    
    [self.contentView addSubview:_weekSummaryLabel];
    [self.contentView addSubview:_weekCountCircleImageView];
    [self.contentView addSubview:_weekLabel];
    [self.contentView addSubview:_weekCompletedCircleImageView];
    [self.contentView addSubview:_weekPercentCompletedLabel];
    
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_cell_background.png"]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_cell_background_selected.png"]];
  }
  return self;
}

-(void) layoutSubviews
{
  [super layoutSubviews];
  
  _weekCountCircleImageView.frame = CGRectMake(0,0,60,60);
  _weekLabel.frame = CGRectMake(0,2,60,60);
  
  if(_weekPercentCompleted == 100) {
    _weekSummaryLabel.frame = CGRectMake(62,0,60,60);
    _weekPercentCompletedLabel.font=[UIFont fontWithName:@"venirNext-Medium" size:18.0];
    
    _weekCompletedCircleImageView.frame = CGRectMake(123,0,136,60);
    
    
  }
  else {
    _weekSummaryLabel.frame = CGRectMake(62,0,200,60);
    _weekPercentCompletedLabel.font=[UIFont fontWithName:@"venirNext-Medium" size:20.0];
    
    if(_weekPercentCompleted) {
      _weekCompletedCircleImageView.frame = CGRectMake(184,0,76,60);
    }
    
  }
  _weekPercentCompletedLabel.frame = _weekCompletedCircleImageView.frame;
  
  BOOL hidePercent = _weekPercentCompleted ? NO : YES;
  
  _weekCompletedCircleImageView.hidden = _weekPercentCompletedLabel.hidden = hidePercent;
  
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  if(selected) {
    _weekLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"list_cell_background_selected.png"]];
    _weekSummaryLabel.textColor = [UIColor whiteColor];
    _weekPercentCompletedLabel.textColor = [UIColor whiteColor];
    
    
    _weekCountCircleImageView.image = [UIImage imageNamed:@"list_cell_week_count_circle_selected.png"];
    
  }
  else {
    _weekLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"list_cell_background.png"]];
    _weekSummaryLabel.textColor = [UIColor lightGrayColor];
    
    
    _weekPercentCompletedLabel.textColor = [UIColor lightGrayColor];
    
    _weekCountCircleImageView.image = [UIImage imageNamed:@"list_cell_week_count_circle.png"];
  }
  
  
}

- (void) setupWithWeekText:(NSString *)weekText weekSummaryText:(NSString *)weekSummaryText weekPercentCompleted:(NSInteger)weekPercentCompleted
{
  _weekPercentCompleted = weekPercentCompleted;
  
  _weekLabel.text = weekText;
  _weekSummaryLabel.text = weekSummaryText;
  
  if(_weekPercentCompleted > 0) {
    if(_weekPercentCompleted == 100) {
      _weekPercentCompletedLabel.text = @"COMPLETED";
    }
    else {
      _weekPercentCompletedLabel.text = [NSString stringWithFormat:@"%d%%", weekPercentCompleted];
    }
    
  }
}



@end
