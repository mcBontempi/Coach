//
//  DurationViewController.h
//  Coach
//
//  Created by Daren Taylor on 24/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DurationViewControllerDelegate.h"

@interface DurationViewController : UIViewController

@property (nonatomic, weak) id<DurationViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<DurationViewControllerDelegate>) delegate;

@end
