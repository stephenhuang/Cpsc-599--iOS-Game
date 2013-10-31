//
//  ballScene.h
//  Game Prototypes
//
//  Created by Stephen  on 2013-10-18.
//  Copyright (c) 2013 Stephen . All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ballScene : SKScene
@property BOOL contentCreated;

@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@end
