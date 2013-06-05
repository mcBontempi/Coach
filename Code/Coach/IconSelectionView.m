#import "IconSelectionView.h"

@interface IconSelectionView ()


@property (nonatomic, strong) NSArray *images;
@property CGSize iconSize;
@property NSInteger padding;

@property (nonatomic, weak) id<IconSelectionViewDelegate> delegate;

@end


@implementation IconSelectionView

- (id)initWithPoint:(CGPoint)point images:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<IconSelectionViewDelegate>) delegate
{
  self = [super initWithFrame:CGRectMake(point.x, point.y, 0,0)];
  if (self) {
    [self setupWithImages:images iconSize:iconSize padding:padding delegate:delegate];
  }
  return self;
}

- (void)setupWithImages:(NSArray*) images iconSize:(CGSize) iconSize padding:(NSInteger) padding delegate:(id<IconSelectionViewDelegate>) delegate
{
  self.images = images;
  self.iconSize = iconSize;
  self.padding = padding;
  self.delegate = delegate;
}

-(void) setSelectedIndex:(NSInteger) selectedIndex
{
  self.currentItemIndex = selectedIndex;
  
  for (UIView *view in [self subviews])
  {
    [view removeFromSuperview];
  }
  
  CGFloat x = 0;
  CGFloat y = 0;
  
  NSInteger index = 0;

  
  for(UIImage *image in self.images){
    
    if(index ==2) { x=0 ; y+=self.iconSize.height + self.padding;}
    
    x+=self.padding;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x,self.padding + y, self.iconSize.width, self.iconSize.height)];
    button.tag = index;
    
    [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:image forState:UIControlStateNormal ];
    
    x+=self.iconSize.width;
    
    [self addSubview:button];
    
    if(selectedIndex == index){
      button.alpha = 1.0;
    }
    else{
      button.alpha = 0.5;
    }
    
    
    index++;
  }
  
  CGRect frame = self.frame;
  
  // we set the actual size here, theres no point setting it from the initializer
  // as we dont know the final size.
  frame.size = CGSizeMake(x+self.padding, y+ self.padding*2 + self.iconSize.height);
  
  self.frame = frame;
  
  
}

- (void) itemPressed:(UIControl *)sender{
  [self setSelectedIndex:sender.tag];
  
  if([self.delegate respondsToSelector:@selector(IconSelectionViewDelegate_iconSelected:)]){
    [self.delegate IconSelectionViewDelegate_iconSelected:sender.tag];
  }
}






@end
