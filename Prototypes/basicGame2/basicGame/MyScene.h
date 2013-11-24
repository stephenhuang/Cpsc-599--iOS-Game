//
//  MyScene.h
//  basicGame
//

//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface MyScene : SKScene {
        AVAudioPlayer* myAudioPlayer;
}

- (void)sayThis:(NSString*)text;

@end
