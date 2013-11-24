//
//  GameTimer.m
//  basicGame
//
//  Created by Stephen  on 11/22/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "GameTimer.h"

@implementation GameTimer
- (id)init{
    self = [super init];
    
    if (self) {
        //Setting up timer
        _gameStart= [NSDate date];
        _paused = false;
        _difficultyInterval = 0.5;
        _difficultyStages = 50;
        _creationThreshold = 20;
        _speedThreshold = 45;
        

    }
    
    return self;
}

-(float)getTime{
    _timeElapsed = fabs([_gameStart timeIntervalSinceNow]);
    
    float temporaryPauseTime =0;
    if (_paused == true){
        temporaryPauseTime = fabs([_pauseStart timeIntervalSinceNow]);
    }
    _timeElapsed = _timeElapsed - _amountPaused - temporaryPauseTime;
    return _timeElapsed - _amountPaused - temporaryPauseTime;
}

-(void)gamePaused{
        _pauseStart= [NSDate date];
        _paused = false;
}
-(void)gameResumed{
    _amountPaused += fabs([_pauseStart timeIntervalSinceNow]);
    _paused = true;
}

-(float)getDifficulty{
    int diff = 1;
    float time = [self getTime];
    
    while(diff*_difficultyInterval < time){
        diff++;
    }
    if (diff > _difficultyStages){
        return _difficultyStages;
    }
    else{
        return diff;
    }
}
-(Boolean)creationThresholdPassed: (float)stage{
    if ( stage < _creationThreshold){
        return false;
    }
    else {
        return true;
    }
}
-(Boolean)speedThresholdPassed: (float)stage{
    if ( stage < _speedThreshold){
        return false;
    }
    else {
        return true;
    }
}

//@interface GameTimer : NSObject
//@property (nonatomic) NSDate* gameStart;
//@property (nonatomic) float amountPaused;
//@property (nonatomic) NSDate* pauseStart;
//@property (nonatomic) NSTimeInterval timeElapsed;
//@property (nonatomic) float diffucltyStages;
//@property (nonatomic) float creationThreshold;
//@property (nonatomic) float speedThreshold;

@end
