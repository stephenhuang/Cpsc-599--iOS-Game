//
//  GameOverMenuViewController.h
//  basicGame
//
//  Created by Robert Siry on 2013-11-27.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameOverMenuViewController : UIViewController

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *replayButton;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *p1Score;
@property (weak, nonatomic) IBOutlet UILabel *p2Score;

//Actions
- (IBAction)replayGame:(id)sender;


//Public
- (void)setScoresForMenu:(NSString *)score;

@end
