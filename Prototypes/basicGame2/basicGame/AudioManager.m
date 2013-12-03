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
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"GameMusic" ofType: @"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
        myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        myAudioPlayer.numberOfLoops = -1; //infinite loop
        
        NSString *soundFileBattle = [[NSBundle mainBundle] pathForResource:@"battlemusic" ofType: @"mp3"];
        NSURL *fileURLBattle = [[NSURL alloc] initFileURLWithPath:soundFileBattle];
        myAudioPlayerBattle = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURLBattle error:nil];
        myAudioPlayerBattle.numberOfLoops = -1; //infinite loop
        
        
        //PoweupSounds
        healthUpBeat = [SKAction playSoundFileNamed:@"HealthUp.mp3" waitForCompletion:YES];
        healthDownBeat = [SKAction playSoundFileNamed:@"HealthDown.mp3" waitForCompletion:YES];
        loseBeat = [SKAction playSoundFileNamed:@"lose.mp3" waitForCompletion:YES];
        
        //[myAudioPlayer play];
        
        //Hit Sounds
        playerHitBeat= [SKAction playSoundFileNamed:@"collide.mp3" waitForCompletion:NO];
    }
    return self;
}
-(void) playBattleBeat
{
    myAudioPlayerBattle.volume = 0.1;
    [myAudioPlayerBattle play];
}

-(void) volumeFadeInBattle
{
	//printf("volumeBattle= %f", myAudioPlayerBattle.volume);
    if (myAudioPlayerBattle.volume < 1)
    {
        myAudioPlayerBattle.volume = myAudioPlayerBattle.volume + 0.1;
        [self performSelector:@selector(volumeFadeInBattle) withObject:nil afterDelay:0.1];
    }
}

-(void) pauseBattleBeat
{
    [myAudioPlayerBattle stop];
}

-(void) volumeFadeBattle
{
	if (myAudioPlayerBattle.volume > 0.1)
    {
        myAudioPlayerBattle.volume = myAudioPlayerBattle.volume - 0.065;
        [self performSelector:@selector(volumeFadeBattle) withObject:nil afterDelay:0.2];
    }
	else{
        [myAudioPlayerBattle stop];
        //myAudioPlayer.currentTime = 0;
        [myAudioPlayerBattle prepareToPlay];
        myAudioPlayerBattle.volume = 1.0;
    }
}

-(void) playBaseBeat{
    //myAudioPlayer.volume = 0.1;
    [myAudioPlayer play];
}

-(void) playFadeBaseBeat{
    myAudioPlayer.volume = 0.1;
    [myAudioPlayer play];
}

-(void) stopBaseBeat{
    [myAudioPlayer stop];
    myAudioPlayer.currentTime = 0;
    [myAudioPlayer prepareToPlay];
}
-(void)rewindBeat
{
    myAudioPlayer.currentTime = 0;
}

-(SKAction*)getHealthUpBeat{
    return healthUpBeat;
}

-(SKAction*)getloseBeat{
    return loseBeat;
}

-(SKAction*)gethealthDownBeat{
    return healthDownBeat;
}

-(SKAction *)getPlayerHitBeat{
    return playerHitBeat;
}

-(void) volumeFade
{
	if (myAudioPlayer.volume > 0.1)
        {
            myAudioPlayer.volume = myAudioPlayer.volume - 0.1;
            [self performSelector:@selector(volumeFade) withObject:nil afterDelay:0.1];
            }
	else{
        [myAudioPlayer stop];
        //myAudioPlayer.currentTime = 0;
        [myAudioPlayer prepareToPlay];
        myAudioPlayer.volume = 1.0;
        }
}

-(void) volumeFadeIn
{
	//printf("volume = %f", myAudioPlayer.volume);
    if (myAudioPlayer.volume < 1)
    {
        myAudioPlayer.volume = myAudioPlayer.volume + 0.1;
        [self performSelector:@selector(volumeFadeIn) withObject:nil afterDelay:0.1];
    }
}
@end
