//
//  StackedProfileGraph.m
//  Coach
//
//  Created by daren taylor on 25/09/2012.
//  Copyright (c) 2012 Daren Taylor. All rights reserved.
//

#import "StackedProfileGraph.h"
#import "SlotLogger.h"
#import "DataUtil.h"

@implementation StackedProfileGraph

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.

// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.5,0.5,0.5,1.0);
	CGContextFillRect(context, rect);
    
    
    // set up the oft used stuff
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    NSInteger colCount = self.slots.count;
    
    CGFloat colWidth =  width / colCount;
    
    CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
	
    [SlotLogger logSlots:self.slots];
    
    NSInteger minutesShown = 8*60;
    
    double runningTotal = 0;
    
    NSInteger col = 0;
    for(Slot *slot in self.slots){
        
        NSInteger duration = slot.duration;
        
        CGFloat barTop = (height / minutesShown) * (duration + runningTotal);
        CGFloat barHeight = (height / minutesShown) * duration;
        
        CGContextSetFillColorWithColor(context,[DataUtil fillCGColorRefOfActivityType:slot.activityType]);
        
        CGContextFillRect(context, CGRectMake(colWidth*col,height - barTop,colWidth,barHeight) );
        
        runningTotal+= duration;
        
        col++;
    }}
@end
