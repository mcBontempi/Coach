#import "CheckboxButton.h"

@interface CheckboxButton ()

-(void) setup;
-(void) checked;

@end

@implementation CheckboxButton

#pragma mark - Object Lifetime

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        [self setup];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setup];
    }
    return self;
}

#pragma mark - General

-(void) setup
{
    [self setImage:[UIImage imageNamed:@"tickbox_off.png"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"tickbox_on.png"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(checked) forControlEvents:UIControlEventTouchUpInside ]; 
}

#pragma mark - UI Actions

-(void) checked
{
   self.selected = !self.selected;
}

@end
