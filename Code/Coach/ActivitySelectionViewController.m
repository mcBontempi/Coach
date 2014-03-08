//
//  ActivitySelectionViewController.m
//  Coach
//
//  Created by Daren taylor on 09/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import "ActivitySelectionViewController.h"

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
  
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                        target:self
                                                                                       action:@selector(cancelPressed:)];


}


- (IBAction)cancelPressed:(id)sender
{
  [self.delegate ActivitySelectionViewControllerDelegate_Cancelled];
  
  [self dismissViewControllerAnimated:YES completion:nil];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
    NSDictionary *itemDictionary = self.array[indexPath.row];
  
    cell.imageView.image = [itemDictionary objectForKey:@"imagePath"];
    cell.textLabel.text = [itemDictionary objectForKey:@"name"];
  
  cell.textLabel.backgroundColor = [UIColor clearColor];
  
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [self.delegate ActivitySelectionViewControllerDelegate_itemSlected:indexPath.row];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
