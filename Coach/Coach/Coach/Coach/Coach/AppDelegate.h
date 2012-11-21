//
//  AppDelegate.h
//  Coach
//
//  Created by Daren Taylor on 18/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppAgent.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, strong) AppAgent *appAgent;

@end
