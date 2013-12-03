//
//  Gameplay.h
//  basicGame
//
//  Created by Stephen  on 10/31/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#import "MyScene.h"
#import "Player.h"
#import "PowerNodes.h"
#import "AppDelegate.h"
#import "GameTimer.h"
#import "GameOverScene.h"

#import "GameOverMenuViewController.h"
#import "BattleViewController.h"

@interface Gameplay : SKScene <BattleDelegateProtocol,GameOverMenuProtocol> {
    @public
    
            AudioManager *AudioPlayer;
    
    @private
}
@property BOOL contentCreated;
-(id)initWithSize:(CGSize)size andAudio:(AudioManager*) audio;
-(void) addToCollisionGroup: (SKSpriteNode*) Node : (NSString*) group;
@end
