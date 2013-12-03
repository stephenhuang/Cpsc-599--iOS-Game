//
//  Player.m
//  basicGame
//
//  Created by Stephen  on 11/2/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id)init:(int)playerNumber{
    self = [super init];
    
    if (self) {
        _playerNumber = playerNumber;
        _score = 100;
        _y= 0;
    }
    
    return self;
}

- (id)initPlayer:(int)playerNumber withPosition:(CGPoint)startingPosition withImage:(NSString*)imageName
{
    self = [super initWithImageNamed:imageName];
    
    
    if (self) {
        _playerNumber = playerNumber;
        _startingPosition = startingPosition;
        _score = 100;
        _y= 0;
        self.position = startingPosition;
        
        self.xScale= 0.3;
        self.yScale= 0.3;

        
        //Add Physics
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.dynamic = NO;
        self.name = [NSString stringWithFormat:@"player%@",  [NSString stringWithFormat:@"%i", playerNumber]];
    }
    return self;
}
-(void)decreaseHealth:(int)amount{
    _score -=amount;
}

-(void)increaseHealth:(int)amount{
    _score += amount;
}
-(int)getHealth{
    return _score;
}

@end
