//
//  AudioManager.m
//  basicGame
//
//  Created by Stephen  on 11/25/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "AudioManager.h"

@implementation AudioManager
- (id)init{
    self = [super init];
    
    if (self) {
        //start a background sound
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"gamebeatz4real" ofType: @"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
        myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        myAudioPlayer.numberOfLoops = -1; //infinite loop
        
        //PoweupSounds
        healthUpBeat = [SKAction playSoundFileNamed:@"HealthUp.mp3" waitForCompletion:YES];
        healthDownBeat =[SKAction playSoundFileNamed:@"HealthDown.mp3" waitForCompletion:YES];
        //[myAudioPlayer play];
        
        //Hit Sounds
        playerHitBeat= [SKAction playSoundFileNamed:@"hit1.mp3" waitForCompletion:NO];
    }
    
    return self;
}
-(void) playBaseBeat{
    [myAudioPlayer play];
}

-(SKAction*)getHealthUpBeat{
    return healthUpBeat;
}

-(SKAction*)gethealthDownBeat{
    return healthDownBeat;
}

-(SKAction *)getPlayerHitBeat{
    return playerHitBeat;
}
@end
