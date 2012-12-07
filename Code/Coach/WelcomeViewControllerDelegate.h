#import <Foundation/Foundation.h>

@protocol WelcomeViewControllerDelegate <NSObject>

-(void) WelcomeViewControllerDelegate_getStartedPressed;
-(void) WelcomeViewControllerDelegate_cancelPressed;

@end
