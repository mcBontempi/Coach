//
//  WelcomeViewController.m
//  Coach
//
//  Created by Daren Taylor on 24/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()
- (IBAction)getStartedPressed:(id)sender;

@end

@implementation WelcomeViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"WelcomeViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"WelcomeViewController_iPad" bundle:nil];
    }
    if(self){
        self.delegate = delegate;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStartedPressed:(id)sender {
    
    [self.delegate WelcomeViewControllerDelegate_getStartedPressed];
}
@end
