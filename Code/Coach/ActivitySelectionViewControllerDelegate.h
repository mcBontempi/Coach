//
//  ActivitySelectionViewControllerDelegate.h
//  Coach
//
//  Created by Daren taylor on 17/02/2014.
//  Copyright (c) 2014 Daren Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActivitySelectionViewControllerDelegate <NSObject>

- (void)ActivitySelectionViewControllerDelegate_itemSlected:(NSUInteger)index;
- (void)ActivitySelectionViewControllerDelegate_Cancelled;

@end
