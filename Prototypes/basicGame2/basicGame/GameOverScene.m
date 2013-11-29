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
        NSLog(@"initializing");
        
        finalscores = @"";
        self.backgroundColor =[UIColor blackColor];
        
        gameOverMenu = [[GameOverMenuViewController alloc]initWithNibName:@"GameOverMenuViewController" bundle:nil];
        
        //[self.view addSubview:gameOverMenu.view];
        
        UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
        [mainWindow addSubview: gameOverMenu.view];

    }
    //finalscores = [NSString stringWithFormat:@"%i - %i", p1score,p2score];
    return self;
}

- (void)setScoresForMenu: (int)p1: (int)p2
{
    //Remove this later
    finalscores = [NSString stringWithFormat:@"%i - %i", p1,p2];
    [gameOverMenu setScoresForMenu:finalscores];
    
}

- (void)didMoveToView:(SKView *)view
{
    NSLog(@"@HOORRRAAAAY %d", count);
    count++;
    
   // [self.view presentScene:<#(SKScene *)#>]
}

@end
