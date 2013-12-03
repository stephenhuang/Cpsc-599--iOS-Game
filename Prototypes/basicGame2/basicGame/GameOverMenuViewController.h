//
//  GameOverMenuViewController.h
//  basicGame
//
//  Created by Robert Siry on 2013-11-27.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GameOverMenuProtocol

-(void)restartGame;

@end
@interface GameOverMenuViewController : UIViewController

//Buttons
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *replayButton;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *p1Score;
@property (weak, nonatomic) IBOutlet UILabel *p2Score;
@property (weak, nonatomic) IBOutlet UILabel *p1Message;
@property (weak, nonatomic) IBOutlet UILabel *p2Message;

//Actions
- (IBAction)replayGame:(id)sender;


//Public
- (void)setScoresForMenu:(NSString *)score;

//Menu Opitons Delegate
@property id <GameOverMenuProtocol> delegate;

@end
