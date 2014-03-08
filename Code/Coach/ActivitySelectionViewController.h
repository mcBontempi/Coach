//
//  ActivitySelectionViewController.h
//  Coach
//
//  Created by Daren taylor on 09/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivitySelectionViewControllerDelegate.h"

@interface ActivitySelectionViewController : UITableViewController

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, weak) id<ActivitySelectionViewControllerDelegate> delegate;
@property (nonatomic) NSUInteger initialSelectedRow;

@end
