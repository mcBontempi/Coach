//
//  ActivitySelectionViewController.m
//  Coach
//
//  Created by Daren taylor on 09/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import "ActivitySelectionViewController.h"
#import "ActivitySelectionTableViewCell.h"

@interface ActivitySelectionViewController ()

@end

@implementation ActivitySelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                        target:self
                                                                                        action:@selector(donePressed:)];
  
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                       action:@selector(cancelPressed:)];
  
}

- (IBAction)donePressed:(id)sender
{
  [self.delegate ActivitySelectionViewControllerDelegate_itemSlected:self.tableView.indexPathForSelectedRow.row];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelPressed:(id)sender
{
  [self.delegate ActivitySelectionViewControllerDelegate_Cancelled];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActivitySelectionTableViewCelldentifier";
    ActivitySelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    NSDictionary *itemDictionary = self.array[indexPath.row];
  
    cell.iconImageView.image = [itemDictionary objectForKey:@"imagePath"];
    cell.name.text = [itemDictionary objectForKey:@"name"];
  
    return cell;
}

@end
