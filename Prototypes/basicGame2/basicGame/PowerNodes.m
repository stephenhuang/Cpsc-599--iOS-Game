//
//  PowerNodes.m
//  basicGame
//
//  Created by Igor Djorganoski on 11/10/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "PowerNodes.h"

@implementation PowerNodes

- (id)init:(int)powerNumber{
    self = [super init];
    
    if (self) {
        _powerNumber = powerNumber;
        
        _y= 0;
    }
    
    return self;
}

- (id)initPlayer:(int)powerNumber withPosition:(CGPoint)startingPosition withImage:(NSString*)imageName
{
    self = [super initWithImageNamed:imageName];
    
    if (self) {
        _powerNumber = powerNumber;
        _startingPosition = startingPosition;
        
        _y= 0;
        self.position = startingPosition;
        
        //Add Physics
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.name = @"powerNode";
    }
    return self;
}

-(void)pickType{
    NSString *imageName;
    float randX = arc4random_uniform(768) + 5;
    float randY = arc4random_uniform(768) + 5;
    float powerType = arc4random_uniform(75)+3;
    
    //Selection of PowerUp Type
    if (powerType < 35) {
        //if = 1 + 5
        powerType = 3;
        imageName = @"3.png";
//        healthAmount = 5;
        //if = 0 -5
    }
    
    else {
        powerType = 4;
        imageName = @"4.png";
//        healthAmount = -5;
    }
}

@end
