//
//  AppAgent.m
//  Coach
//
//  Created by Daren Taylor on 20/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "AppAgent.h"
#import "ProfileViewController.h"
#import "StackedProfileViewController.h"
#import "Profile.h"
#import "Coach.h"

#import "ConfigAgent.h"
#import "ViewerAgent.h"

@interface AppAgent ()

@property (nonatomic, strong) ConfigAgent *configAgent;
@property (nonatomic, strong) ViewerAgent *viewerAgent;


@end

@implementation AppAgent

-(void) showProfileViewController{
    // test data
    
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    ProfileViewController *vc = [[ProfileViewController alloc] init];
    vc.profile = profile;
    [self.rootViewController presentModalViewController:vc animated:YES];
}


-(void) showStackedProfileViewController{
    // test data
    
    const NSInteger length = 45;
    
    Profile *profile = [[Profile alloc] init];
    profile.numberOfWeeks = length;
    profile.startPercentage =30;
    [profile generate];
    
    
    //for(NSInteger week = 1 ; week <= length ; week++){
    
    
    Coach *coach = [[Coach alloc] init];
    coach.profile = profile;
    coach.peakMinutes = 20*60;
    
    NSArray *week = [coach getStackedWeekUsesProfileWithWeek:1];
    
    StackedProfileViewController *vc = [[StackedProfileViewController alloc] init];
    vc.slots = week;
    
    [self.rootViewController presentModalViewController:vc animated:YES];
}


-(void) startConfigWizard{
    
    self.configAgent = [[ConfigAgent alloc] init];
    self.configAgent.rootViewController = self.rootViewController;
    
    [self.configAgent start];
}

-(void) startViewer{
    
    self.viewerAgent = [[ViewerAgent alloc] init];
    self.viewerAgent.rootViewController = self.rootViewController;
    
    [self.viewerAgent start];
}

-(void) start{
    
    //[self startConfigWizard];
    
    [self startViewer];
    
}





@end
