//
//  GameOverScene.m
//  basicGame
//
//  Created by Stephen  on 11/23/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "GameOverScene.h"
#import "MyScene.h"
#import "GameOverMenuViewController.h"

int count =0;
NSString* finalscores;
GameOverMenuViewController *gameOverMenu;

@implementation GameOverScene
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */        
    }
    //finalscores = [NSString stringWithFormat:@"%i - %i", p1score,p2score];
    finalscores = @"";
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
     SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:113/255.0f green:209/255.0f blue:236/255.0f alpha:1.0f]
     size:screenSize];
     background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
     [self addChild:background];
    
    //gameOverMenu = [[GameOverMenuViewController alloc]initWithNibName:@"GameOverMenuViewController" bundle:nil];
    //gameOverMenu.delegate = self;
    return self;
}

- (void)setScoresForMenuPlayer1:(int)p1 player2:(int)p2
{
    //Remove this later
    finalscores = [NSString stringWithFormat:@"%i - %i", p1,p2];
    //[gameOverMenu setScoresForMenu:finalscores];
    
}

- (void)didMoveToView:(SKView *)view
{
    //gameOverMenu = [[GameOverMenuViewController alloc]initWithNibName:@"GameOverMenuViewController" bundle:nil];
    
    //[self.view addSubview:gameOverMenu.view];
    
    //[view addSubview:gameOverMenu.view];
    
}

@end
