//
//  StackedProfileViewController.m
//  Coach
//
//  Created by daren taylor on 25/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "StackedProfileViewController.h"
#import "StackedProfileGraph.h"

@interface StackedProfileViewController ()
@property (weak, nonatomic) IBOutlet StackedProfileGraph *stackedProfileGraph;

@end

@implementation StackedProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.stackedProfileGraph.slots = self.slots;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setStackedProfileGraph:nil];
    [super viewDidUnload];
}
@end
