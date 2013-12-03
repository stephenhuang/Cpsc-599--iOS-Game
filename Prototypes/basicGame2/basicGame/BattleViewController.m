//
//  BattleViewController.m
//  basicGame
//
//  Created by Robert Siry on 2013-11-22.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "BattleViewController.h"
#import "mathTrivaGenerator.h"
#import "otherTrivaGenerator.h"
#import "AudioManager.h"
#import <AVFoundation/AVFoundation.h>

@interface BattleViewController ()

@end

@implementation BattleViewController
{
    NSMutableArray *question;
    UIFont *railwayBig;
    UIFont *railway;
    UIFont *railwayQuestion;
    NSString *answer;
    int playerThatWins;
    BOOL buttonTouched;
    
}

@synthesize questionLabel,questionLabel2,battleLabel2,battleLabel1; //all Labels
@synthesize p1Option1,p1Option2,p1Option3,p1Option4;    //player 1 buttons
@synthesize p2Option1,p2Option2,p2Option3,p2Option4;    //player 2 buttons

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andAudio:(AudioManager*) audio
{
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //Initialize audio player
        AudioPlayer = audio;
    }
    
    railwayBig = [UIFont fontWithName:@"Raleway" size:65];
    railway = [UIFont fontWithName:@"Raleway" size:60];
    railwayQuestion= [UIFont fontWithName:@"Raleway" size:80];
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    buttonTouched=false;
    // Do any additional setup after loading the view from its nib.
    
    //Question
    int whatTriva = ((rand() %100)+1);

    if(whatTriva<64)
    {
        mathTrivaGenerator* triva = [[mathTrivaGenerator alloc] init];
        question =triva.createQuestion;
    }
    else
    {
        otherTrivaGenerator *triva = [[otherTrivaGenerator alloc] init];
        question =triva.createQuestion;
    }
    
    //Setting answer and question labels
    answer =[question objectAtIndex:1];
    questionLabel.text= [question objectAtIndex:0];
    questionLabel2.text =[question objectAtIndex:0];
    
    //setting font
    questionLabel.font = railwayQuestion;
    questionLabel2.font = railwayQuestion;
    p1Option1.titleLabel.font = railway;
    p1Option2.titleLabel.font = railway;
    p1Option3.titleLabel.font = railway;
    p1Option4.titleLabel.font = railway;
    p2Option1.titleLabel.font = railway;
    p2Option2.titleLabel.font = railway;
    p2Option3.titleLabel.font = railway;
    p2Option4.titleLabel.font = railway;
    battleLabel1.font = railwayBig;
    battleLabel2.font = railwayBig;
    
    //Wrapping question label?

    questionLabel.adjustsFontSizeToFitWidth = true;
    questionLabel.lineBreakMode =NSLineBreakByClipping;
    questionLabel2.adjustsFontSizeToFitWidth = true;
    questionLabel2.lineBreakMode =NSLineBreakByClipping;
    
    
    //Player 1 wrapping
    p1Option1.titleLabel.adjustsFontSizeToFitWidth = YES;
    p1Option1.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p1Option2.titleLabel.adjustsFontSizeToFitWidth = YES;
    p1Option2.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p1Option3.titleLabel.adjustsFontSizeToFitWidth = YES;
    p1Option3.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p1Option4.titleLabel.adjustsFontSizeToFitWidth = YES;
    p1Option4.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    //Player 2 wrapping
    p2Option1.titleLabel.adjustsFontSizeToFitWidth = YES;
    p2Option1.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p2Option2.titleLabel.adjustsFontSizeToFitWidth = YES;
    p2Option2.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p2Option3.titleLabel.adjustsFontSizeToFitWidth = YES;
    p2Option3.titleLabel.lineBreakMode = NSLineBreakByClipping;
    p2Option4.titleLabel.adjustsFontSizeToFitWidth = YES;
    p2Option4.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    
    //Rotating UIElemenets for player 2
    [questionLabel2 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [battleLabel2 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [p2Option1 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [p2Option2 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [p2Option3 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    [p2Option4 setTransform:CGAffineTransformMakeRotation(-M_PI )];
    
    //Setting options for player 1
    [p1Option1 setTitle:[question objectAtIndex:2] forState:UIControlStateNormal];
    [p1Option2 setTitle:[question objectAtIndex:3] forState:UIControlStateNormal];
    [p1Option3 setTitle:[question objectAtIndex:4] forState:UIControlStateNormal];
    [p1Option4 setTitle:[question objectAtIndex:5] forState:UIControlStateNormal];
    
    //Setting options for player 2
    [p2Option1 setTitle:[question objectAtIndex:2] forState:UIControlStateNormal];
    [p2Option2 setTitle:[question objectAtIndex:3] forState:UIControlStateNormal];
    [p2Option3 setTitle:[question objectAtIndex:4] forState:UIControlStateNormal];
    [p2Option4 setTitle:[question objectAtIndex:5] forState:UIControlStateNormal];
    
    //this is a test
    printf("View Loaded\n");
    
    [AudioPlayer volumeFade];
    [AudioPlayer playBattleBeat];
    [AudioPlayer volumeFadeInBattle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p1ButtonPress:(id)sender {
    if(!buttonTouched)
    {
        buttonTouched=true;
    [self disableAllButtons];
    if([[sender currentTitle]isEqualToString:answer])
    {
        [self p1Wins];
        
    }
    else
        [self p2Wins];
    }
    
}
- (IBAction)p2ButtonPress:(id)sender {
    if(!buttonTouched)
    {
        buttonTouched=true;
    [self disableAllButtons];
    if([[sender currentTitle]isEqualToString:answer])
    {
        [self p2Wins];
        
    }
    else
        [self p1Wins];
    }
    
}

-(void)p1Wins
{
    [self disableAllButtons];
    [p1Option1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p1Option2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p1Option3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p1Option4 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    questionLabel.textColor = [UIColor greenColor];
    
    [p2Option1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p2Option2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p2Option3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p2Option4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    questionLabel2.textColor = [UIColor redColor];
    
    playerThatWins=1;
    [self fadeOutAndRemove];
    [self performSelector:@selector(notifyGameOfWinner:) withObject:Nil afterDelay:1.6];
    
    [AudioPlayer volumeFadeBattle];
    [AudioPlayer playFadeBaseBeat];
    [AudioPlayer volumeFadeIn];
    }

-(void)p2Wins
{
    [self disableAllButtons];
    [p1Option1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p1Option2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p1Option3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [p1Option4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    questionLabel.textColor = [UIColor redColor];
    
    [p2Option1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p2Option2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p2Option3 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [p2Option4 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    questionLabel2.textColor = [UIColor greenColor];
    
    playerThatWins=2;
    [self fadeOutAndRemove];
    [self performSelector:@selector(notifyGameOfWinner:) withObject:Nil afterDelay:1.6];
    
    [AudioPlayer volumeFadeBattle];
    [AudioPlayer playFadeBaseBeat];
    [AudioPlayer volumeFadeIn];

}


-(void)disableAllButtons
{
    p1Option1.enabled = NO;
    p1Option2.enabled = NO;
    p1Option3.enabled = NO;
    p1Option4.enabled = NO;
    
    p2Option1.enabled = NO;
    p2Option2.enabled = NO;
    p2Option3.enabled = NO;
    p2Option4.enabled = NO;
}
-(void)notifyGameOfWinner:(UIView*) current
{
    [self.delegate playerThatWins:playerThatWins];
    [self.view removeFromSuperview];
}

-(void)fadeOutAndRemove
{
    [UIView animateWithDuration:1.0 animations:^{
        
        self.view.alpha = 0.0;
        
    }];
    
    
    //[self removeFromParentViewController];    //Doesn't actually remove from View!
    
}
@end
