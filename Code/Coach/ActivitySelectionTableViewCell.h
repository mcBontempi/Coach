//
//  ActivitySelectionTableViewCell.h
//  Coach
//
//  Created by Daren taylor on 09/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitySelectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *description;
@end
