//
//  GameOverMenuViewController.m
//  basicGame
//
//  Created by Robert Siry on 2013-11-27.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "GameOverMenuViewController.h"

UIFont *railwayBig;
UIFont *railway;

@interface GameOverMenuViewController ()

@end

@implementation GameOverMenuViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setScoresForMenu:(int)p1:(int)p2
{
    NSString *finalScores = [NSString stringWithFormat:@"%i - %i", p1,p2];
    p1Score.text = finalScores;
    p2Score.text = finalScores;

}

@end
