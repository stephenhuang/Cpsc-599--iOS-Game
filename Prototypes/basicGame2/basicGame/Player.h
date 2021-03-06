//
//  Player.h
//  basicGame
//
//  Created by Stephen  on 11/2/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Player : SKSpriteNode

@property int playerNumber;
@property int score;
@property float y;
@property CGPoint startingPosition;

- (id)initPlayer:(int)playerNumber withPosition:(CGPoint)startingPosition withImage:(NSString*)imageName;
- (int)getHealth;
- (void)decreaseHealth:(int)amount;
- (void)increaseHealth:(int)amount;

@end
