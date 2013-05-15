//
//  ListViewCell.m
//  Coach
//
//  Created by daren taylor on 22/04/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import "ListViewCell.h"

@implementation ListViewCell{
  
  UILabel *_weekLabel;
  UILabel *_weekSummaryLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _weekLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _weekLabel.textColor = [UIColor darkGrayColor];
    _weekLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:22.0];
    _weekLabel.backgroundColor = [UIColor whiteColor];
    
    _weekSummaryLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _weekSummaryLabel.textColor = [UIColor grayColor];
    _weekSummaryLabel.font=[UIFont fontWithName:@"Trebuchet MS" size:14.0];
    _weekSummaryLabel.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_weekLabel];
    [self.contentView addSubview:_weekSummaryLabel];
  }
  return self;
}

-(void) layoutSubviews
{
  [super layoutSubviews];

  _weekLabel.frame = CGRectMake(5,5,320,20);
  _weekSummaryLabel.frame = CGRectMake(5,25,320,20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
}

- (void) setupWithWeekText:(NSString *)weekText weekSummaryText:(NSString *)weekSummaryText
{
  _weekLabel.text = weekText;
  _weekSummaryLabel.text = weekSummaryText;
}



@end
