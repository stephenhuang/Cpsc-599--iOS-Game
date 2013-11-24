//
//  AppDelegate.h
//  basicGame
//
//  Created by Robert Siry on 2013-10-25.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    AVAudioPlayer* myAudioPlayer;
}

@property (nonatomic, retain) AVAudioPlayer *myAudioPlayer;
@property (strong, nonatomic) UIWindow *window;

@end
