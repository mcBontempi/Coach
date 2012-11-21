//
//  TypeSelectViewController.m
//  Coach
//
//  Created by Daren Taylor on 24/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "TypeSelectViewController.h"

@interface TypeSelectViewController ()
- (IBAction)sprintPressed:(id)sender;
- (IBAction)halfPressed:(id)sender;
- (IBAction)fullPressed:(id)sender;

@end

@implementation TypeSelectViewController

-(id) init{
    NSException *exception = [NSException exceptionWithName:@"you must use the explicit initializer" reason:@"" userInfo:nil];
    [exception raise];
    return nil;
}

-(id) initWithDelegate:(id<TypeSelectViewControllerDelegate>) delegate{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self = [super initWithNibName:@"TypeSelectViewController_iPhone" bundle:nil];
    } else {
        self = [super initWithNibName:@"TypeSelectViewController_iPad" bundle:nil];
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

- (IBAction)sprintPressed:(id)sender {
    [self.delegate TypeSelectViewControllerDelegate_typePressed:ETypeSprint];
}

- (IBAction)halfPressed:(id)sender {
    [self.delegate TypeSelectViewControllerDelegate_typePressed:ETypeHalf];
}

- (IBAction)fullPressed:(id)sender {
    [self.delegate TypeSelectViewControllerDelegate_typePressed:ETypeFull];
}
@end
