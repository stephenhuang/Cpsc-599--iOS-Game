//
//  PowerNodes.m
//  basicGame
//
//  Created by Igor Djorganoski on 11/10/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "PowerNodes.h"

@implementation PowerNodes

- (id)init{
    [self pickType];
    self = [super initWithImageNamed:_powerupIcon];
//    self = [super init];
  
    if (self) {
     //   [self pickType];
        [self pickPosition];
        _y= 0;
    }

    self.name = @"powerNode";
    self.position = _startingPosition;
    self.xScale = _iconSize;
    self.yScale = _iconSize;

    
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/10];

    self.physicsBody.dynamic = YES;
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.linearDamping = 0.0;
    self.physicsBody.angularDamping = 0.0;
    [self setVelocity];

    return self;
}


    //Selection of PowerUp Type
-(void)pickType{
    float selection= arc4random_uniform(150)+3;
    //selection=998;
    //Health Up
    if (selection < 35) {
        //if = 1 + 5
        _powerType = @"healthUp";
        _powerupIcon = @"healthup.png";
        _iconSize =0.3;
//        healthAmount = 5;
        //if = 0 -5
    }
    //Health Down
    else if (selection < 60){
        _powerType = @"healthDown";
        _powerupIcon= @"healthdown.png";
        _iconSize =0.3;
    }
    else if (selection < 99){
        _powerupIcon= @"battle.png";
        _powerType = @"battle";
        _iconSize =0.4;
    }
    else if (selection < 150){
        _powerupIcon= @"misslePowerUp.png";
        _powerType = @"missle";
        _iconSize =0.4;
    }
    else{
    //send all node
        _powerupIcon= @"sendAllNodes.png";
        _powerType = @"sendAllNodes";
        _iconSize =0.4;
    }
//    _powerupIcon= @"battle.png";
//    _powerType = @"battle";
//    _iconSize =0.4;
}

-(void)setVelocity{
    float vx;
    float vy;
    if (_startingPosition.x < 384){
        vx = -30;
    }
    else{
        vx = 30;
    }
    if (_startingPosition.y < 512){
        vy = 30;
    }
    else{
        vy = -30;
    }
        
    self.physicsBody.velocity = CGVectorMake(vx,vy);
}
-(void)pickPosition{

    
    float randY;
    do {
       randY = arc4random_uniform(1024);
    } while (randY > 256 && randY < 768);
    
    float randX;
    do {
        randX = arc4random_uniform(768);
    } while (randX > 700 && randX < 75 );
    

    _startingPosition = CGPointMake(randX, randY);
}

-(NSString*)getPowerType{
    return _powerType;
}
@end
