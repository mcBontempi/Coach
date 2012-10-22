//
//  WelcomeViewController.h
//  Coach
//
//  Created by Daren Taylor on 24/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewControllerDelegate.h"

@interface WelcomeViewController : UIViewController

    @property (nonatomic, weak) id<WelcomeViewControllerDelegate> delegate;

    -(id) initWithDelegate:(id<WelcomeViewControllerDelegate>) delegate;

@end
