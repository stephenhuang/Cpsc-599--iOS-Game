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
    self.physicsBody.velocity = CGVectorMake(0,-100);
    return self;
}


    //Selection of PowerUp Type
-(void)pickType{
    float selection= arc4random_uniform(75)+3;

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
    else{
    //send all node
        _powerupIcon= @"sendAllNodes.png";
        _powerType = @"sendAllNodes";
        _iconSize =0.4;
    }
    _powerupIcon= @"sendAllNodes.png";
    _powerType = @"sendAllNodes";
    _iconSize =0.4;
}

-(void)pickPosition{
    float randX = arc4random_uniform(768) + 5;
    float randY = arc4random_uniform(768) + 5;

    _startingPosition = CGPointMake(randX, randY);
}

-(NSString*)getPowerType{
    return _powerType;
}
@end
