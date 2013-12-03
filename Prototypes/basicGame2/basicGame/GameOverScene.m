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
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        NSLog(@"initializing");
        
        finalscores = @"";
        self.backgroundColor = [UIColor colorWithRed:113/255.0f green:209/255.0f blue:236/255.0f alpha:1.0f];
        
        gameOverMenu = [[GameOverMenuViewController alloc]initWithNibName:@"GameOverMenuViewController" bundle:nil];
        
        //[self.view addSubview:gameOverMenu.view];
        
        UIWindow* mainWindow = [[UIApplication sharedApplication] keyWindow];
        [mainWindow addSubview: gameOverMenu.view];
    
    }
    return self;
    
}

- (void)setScoresForMenu:(int)p1:(int)p2
{
    finalscores = [NSString stringWithFormat:@"%i - %i", p1,p2];
    
}

- (void)didMoveToView:(SKView *)view
{
    NSLog(@"@HOORRRAAAAY %d", count);
    count++;
    
}

@end
