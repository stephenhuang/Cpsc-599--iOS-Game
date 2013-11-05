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


@end
