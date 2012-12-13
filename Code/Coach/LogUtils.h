#ifndef ConferencePad_LogUtils_h
#define ConferencePad_LogUtils_h

#define DLog(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__]);
#define DLogWithPrettyFunction(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__]);
#define DLogIn DLogWithPrettyFunction(@">>>>");
#define DLogOut DLogWithPrettyFunction(@"<<<<");


#define QuickAlert(Title, Message) UIAlertView *av = [[UIAlertView alloc] initWithTitle:Title message:Message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [av show];


#endif
