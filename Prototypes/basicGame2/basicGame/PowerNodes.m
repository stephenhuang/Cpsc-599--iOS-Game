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

@end
