//
//  AudioManager.h
//  basicGame
//
//  Created by Stephen  on 11/25/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#include <AudioToolbox/AudioToolbox.h>

@interface AudioManager : NSObject{
    AVAudioPlayer* myAudioPlayer;
    SKAction* healthUpBeat;
    SKAction* healthDownBeat;
    SKAction* hitBeat;
    SKAction* battleModeBeat;
    SKAction* playerHitBeat;
    
}
-(id)init;

-(void) playBaseBeat;
-(SKAction*)getHealthUpBeat;
-(SKAction*)gethealthDownBeat;
-(SKAction *)getPlayerHitBeat;
@end
