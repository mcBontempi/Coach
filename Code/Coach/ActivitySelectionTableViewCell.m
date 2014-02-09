//
//  ActivitySelectionTableViewCell.m
//  Coach
//
//  Created by Daren taylor on 09/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import "ActivitySelectionTableViewCell.h"

@interface ActivitySelectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;


@end

@implementation ActivitySelectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end