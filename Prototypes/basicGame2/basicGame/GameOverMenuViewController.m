//
//  GameOverMenuViewController.m
//  basicGame
//
//  Created by Robert Siry on 2013-11-27.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "GameOverMenuViewController.h"
#import "Gameplay.h"

UIFont *railwayBig;
UIFont *railway;

@interface GameOverMenuViewController ()

@end

@implementation GameOverMenuViewController
{
    Gameplay * gameScene;
}

@synthesize menuButton;
@synthesize replayButton;
@synthesize p1Score,p2Score;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    railwayBig = [UIFont fontWithName:@"Raleway" size:80];
    railway = [UIFont fontWithName:@"Raleway" size:65];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    replayButton.titleLabel.font = railway;
    menuButton.titleLabel.font = railway;
    
    p1Score.font = railwayBig;
    p2Score.font =railwayBig;
    [p2Score setTransform:CGAffineTransformMakeRotation(-M_PI )];   //rotating the label
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setScoresForMenu:(NSString *)score
{
    NSString *finalScores = score;
    p1Score.text = finalScores;
    p2Score.text = finalScores;
}

- (IBAction)replayGame:(id)sender {
   // Gameplay *gameScene = [[Gameplay alloc] initWithSize:self.size andAudio:audioplayer];
    gameScene = [[Gameplay alloc] initWithSize:CGSizeMake(768, 1024)];
    SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:(0.5)];
    
    //SKScene *test = self.view.window.rootViewController.view;
    SKView * skView = [Gameplay sceneWithSize:skView.bounds.size];
    //scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:gameScene];
}
@end
