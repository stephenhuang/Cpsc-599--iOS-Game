//
//  BattleViewController.h
//  basicGame
//
//  Created by Robert Siry on 2013-11-22.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BattleDelegateProtocol

-(void)playerThatWins:(int) player;

@end

@interface BattleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel2;
@property (weak, nonatomic) IBOutlet UILabel *battleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *battleLabel1;

//Player 1
@property (weak, nonatomic) IBOutlet UIButton *p1Option1;
@property (weak, nonatomic) IBOutlet UIButton *p1Option2;
@property (weak, nonatomic) IBOutlet UIButton *p1Option3;
@property (weak, nonatomic) IBOutlet UIButton *p1Option4;

//Player 2
@property (weak, nonatomic) IBOutlet UIButton *p2Option1;
@property (weak, nonatomic) IBOutlet UIButton *p2Option2;
@property (weak, nonatomic) IBOutlet UIButton *p2Option3;
@property (weak, nonatomic) IBOutlet UIButton *p2Option4;

- (IBAction)p1ButtonPress:(id)sender;
- (IBAction)p2ButtonPress:(id)sender;


//player that wins
@property id <BattleDelegateProtocol> delegate;

@end
