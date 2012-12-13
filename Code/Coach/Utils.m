#import "Utils.h"

#import <AVFoundation/AVAudioPlayer.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Utils

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
    float r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)c
{
    float r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}


+(void) playSound:(NSString*) path type:(NSString*) type{
    CFBundleRef mainBundle = CFBundleGetMainBundle(); /* Define mainBundle as the current app's bundle */
    CFURLRef fileURL = CFBundleCopyResourceURL(mainBundle, (__bridge CFStringRef)path, (__bridge CFStringRef)type, NULL); /* Set Bundle as Main Bundle, Define Sound Filename, Define Sound Filetype */
    UInt32 soundID; /* define soundID as a 32Bit Unsigned Integer */
    AudioServicesCreateSystemSoundID (fileURL, &soundID); /* Assign Sound to SoundID */
    AudioServicesPlaySystemSound(soundID); /* Now play the sound associated with this sound ID */
}


@end
