//
//  GameOverScene.m
//  basicGame
//
//  Created by Stephen  on 11/23/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "GameOverScene.h"
int count =0;
@implementation GameOverScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        NSLog(@"initializing");
        
        self.backgroundColor = [UIColor colorWithRed:113/255.0f green:209/255.0f blue:236/255.0f alpha:1.0f];

        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"GAME OVER!!! YOU LOOOOSE";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    return self;
    
}

- (void)didMoveToView:(SKView *)view
{
    NSLog(@"@HOORRRAAAAY %d", count);
    count++;
    
}
@end
