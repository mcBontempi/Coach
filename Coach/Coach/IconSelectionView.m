#import "IconSelectionView.h"

@implementation IconSelectionView

- (id)initWithFrame:(CGRect)frame andImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding selectedIndex:(NSInteger) selectedIndex;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.images = images;
        self.iconSize = iconSize;
        self.padding = padding;
        self.selectedIndex = selectedIndex;
     
        [self setup];
    }
    return self;
}

-(void) setup{
    
    CGFloat x = 0;
    
    NSInteger index = 0;
    
    for(UIImage *image in self.images){
        
        x+=self.padding;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x,self.padding, self.iconSize.width, self.iconSize.height)];
        
        imageView.image = image;
        
        x+=self.iconSize.width;
        
        [self addSubview:imageView];
        
        if(self.selectedIndex == index){
            imageView.alpha = 1.0;
        }
        else{
            imageView.alpha = 0.5;
        }
        
        
        index++;
    }
    
    CGRect frame = self.frame;
    frame.size = CGSizeMake(x+self.padding, self.padding*2 + self.iconSize.height);
    
    self.frame = frame;

    
}



@end
