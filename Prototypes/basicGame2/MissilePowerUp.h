//
//  MissilePowerUp.h
//  basicGame
//
//  Created by Robert Siry on 2013-12-01.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MissilePowerUp : SKSpriteNode

-(void)addMissiles:(SKScene *)game forPlayer:(int)player;
-(void)shotMissle;
-(BOOL)hasMissiles;
-(void)removeMissileHud;
-(void)setToZero;
@end
