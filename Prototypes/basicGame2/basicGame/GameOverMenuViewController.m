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
UIFont *railwayMessage;

@interface GameOverMenuViewController ()

@end

@implementation GameOverMenuViewController
{
    Gameplay * gameScene;
}

@synthesize menuButton;
@synthesize replayButton;
@synthesize p1Score,p2Score,p1Message,p2Message;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    railwayBig = [UIFont fontWithName:@"Raleway" size:80];
    railway = [UIFont fontWithName:@"Raleway" size:60];
    railwayMessage = [UIFont fontWithName:@"Raleway" size:70];
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
    p1Message.font = railwayMessage;
    p2Message.font = railwayMessage;
    
     //rotating player 2 labels
    [p2Score setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [p2Message setTransform:CGAffineTransformMakeRotation(-M_PI )];
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setScoresForMenu:(NSString *)score
{
    //NSString *finalScores = score;
    p1Score.text = score;
    p2Score.text = score;
}

- (IBAction)replayGame:(id)sender {

    [UIView animateWithDuration:1.0 animations:^{
        
        self.view.alpha = 0.0;
        
    }];
    
    [self performSelector:@selector(notifyReplay) withObject:nil afterDelay:1.6];
}

-(void)notifyReplay
{
    [self.view removeFromSuperview];
    [self.delegate restartGame];
}
@end
