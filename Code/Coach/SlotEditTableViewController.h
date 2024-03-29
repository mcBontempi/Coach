//
//  SlotEditTableViewController.h
//  Coach
//
//  Created by daren taylor on 23/05/2013.
//  Copyright (c) 2013 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlotEditViewControllerDelegate.h"
#import "IconSelectionView.h"
#import "ActivitySelectionViewControllerDelegate.h"

@interface SlotEditTableViewController : UITableViewController <IconSelectionViewDelegate, ActivitySelectionViewControllerDelegate>

@property (nonatomic, strong) NSString *model;

-(id) initWithDelegate:(id<SlotEditViewControllerDelegate>) delegate;

@end
