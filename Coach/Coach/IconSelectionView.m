#import "IconSelectionView.h"

@interface IconSelectionView ()


@property (nonatomic, strong) NSArray *images;
@property CGSize iconSize;
@property NSInteger padding;
@property NSInteger selectedIndex;

@property (nonatomic, weak) id<IconSelectionViewDelegate> delegate;

@end


@implementation IconSelectionView

- (id)initWithFrame:(CGRect)frame andImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding selectedIndex:(NSInteger) selectedIndex delegate:(id<IconSelectionViewDelegate>) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = images;
        self.iconSize = iconSize;
        self.padding = padding;
        self.selectedIndex = selectedIndex;
        self.delegate = delegate;
     
        [self setup];
    }
    return self;
}

-(void) setup{
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    CGFloat x = 0;
    
    NSInteger index = 0;
    
    for(UIImage *image in self.images){
        
        x+=self.padding;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x,self.padding, self.iconSize.width, self.iconSize.height)];
        button.tag = index;
        
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
       
        [button setImage:image forState:UIControlStateNormal ];
        
        x+=self.iconSize.width;
        
        [self addSubview:button];
        
        if(self.selectedIndex == index){
            button.alpha = 1.0;
        }
        else{
            button.alpha = 0.5;
        }
        
        
        index++;
    }
    
    CGRect frame = self.frame;
    frame.size = CGSizeMake(x+self.padding, self.padding*2 + self.iconSize.height);
    
    self.frame = frame;

    
}

- (void) itemPressed:(UIControl *)sender{
    self.selectedIndex = sender.tag;
    
    [self setup];
    
    [self.delegate IconSelectionViewDelegate_iconSelected:self.selectedIndex];
}






@end
