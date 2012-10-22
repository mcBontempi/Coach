//
//  ProfileViewController.m
//  Coach
//
//  Created by daren taylor on 20/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileGraph.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet ProfileGraph *profileGraph;

@end

@implementation ProfileViewController

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
    
    
    self.profileGraph.profile = self.profile;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setProfileGraph:nil];
    [super viewDidUnload];
}




@end
