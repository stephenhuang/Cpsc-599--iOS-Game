//
//  GameTimer.h
//  basicGame
//
//  Created by Stephen  on 11/22/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameTimer : NSObject
@property (nonatomic) NSDate* gameStart;
@property (nonatomic) float amountPaused;
@property (nonatomic) NSDate* pauseStart;
@property (nonatomic) NSTimeInterval timeElapsed;
@property Boolean paused;
@property (nonatomic) float difficultyInterval;
@property (nonatomic) float difficultyStages;
@property (nonatomic) float creationThreshold;
@property (nonatomic) float speedThreshold;

-(float)getTime;
-(void)gamePaused;
-(void)gameResumed;
-(float)getDifficulty;
-(Boolean)creationThresholdPassed: (float)stage;
-(Boolean)speedThresholdPassed: (float)stage;
@end
