//
//  TypeSelectViewController.h
//  Coach
//
//  Created by Daren Taylor on 24/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeSelectViewControllerDelegate.h"

@interface TypeSelectViewController : UIViewController

@property (nonatomic, weak) id<TypeSelectViewControllerDelegate> delegate;

-(id) initWithDelegate:(id<TypeSelectViewControllerDelegate>) delegate;

@end
