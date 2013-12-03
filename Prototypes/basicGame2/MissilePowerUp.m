//
//  MissilePowerUp.m
//  basicGame
//
//  Created by Robert Siry on 2013-12-01.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "MissilePowerUp.h"

@implementation MissilePowerUp
{
    int numOfMissiles;
    SKSpriteNode *shoot;
    SKLabelNode *missilesLeft;
}

-(void)setToZero
{
    numOfMissiles=0;
}
-(void)addMissiles:(SKScene *)game forPlayer:(int)player
{
    if([self hasMissiles])
    {
        numOfMissiles =numOfMissiles+3;
    }
    else
    {
        shoot = [SKSpriteNode spriteNodeWithImageNamed:@"shootbutton.png"];
        shoot.xScale = .5;
        shoot.yScale = .5;
        
        missilesLeft = [SKLabelNode labelNodeWithFontNamed:@"Raleway"];
        
        missilesLeft.text = [NSString stringWithFormat:@"%i", numOfMissiles];
        missilesLeft.fontSize = 30;
        missilesLeft.fontColor = [UIColor redColor];
        
        [game addChild:missilesLeft];
        
        if(player==1)
        {
            shoot.name = @"P1ShootButton";
            shoot.position = CGPointMake(60, 60);
            missilesLeft.position = CGPointMake(60,55);
        }
        else
        {
            shoot.name = @"P2ShootButton";
            shoot.position = CGPointMake(704, 964);
            missilesLeft.position = CGPointMake(704,970);
            missilesLeft.zRotation=M_PI;
        }
        
        numOfMissiles=3;
        
        [game addChild:shoot];
    
    }
     [self updateLabel];
}

-(void)shotMissle
{
    numOfMissiles--;
    [self updateLabel];
    
        
}

-(void)updateLabel
{
    missilesLeft.text = [NSString stringWithFormat:@"%i", numOfMissiles];
}

-(BOOL)hasMissiles
{
    if(numOfMissiles>0)
        return true;
    else
        return false;
}

-(void)removeMissileHud
{
    [shoot removeFromParent];
    [missilesLeft removeFromParent];
}


@end
