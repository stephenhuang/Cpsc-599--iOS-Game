//
//  ViewController.m
//  basicGame
//
//  Created by Robert Siry on 2013-10-25.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "Menu.h"

@implementation ViewController

- (void)viewDidLoad
{
    // [super viewDidLoad];
    [super viewWillLayoutSubviews];
	// Do any additional setup after loading the view, typically from a nib.
    [self loadParallax];
    
    //[self transitionToMenu];
    
    
    
    
}

-(void)clearAllViews{
    [parallaxView removeFromSuperview];
    for (UIView *subview in [self.view subviews]){
        [subview removeFromSuperview];
    }
}
-(void)loadParallax{
    // setting background color to black
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    //768 by 1024
    
    // create first scrollview (Background image? Something like the sky)
    _firstScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [_firstScrollView setPagingEnabled:TRUE];
    [_firstScrollView setContentSize:CGSizeMake(4416, 1024)]; // 8 12
    [self.view addSubview:_firstScrollView];
    
    
    // create second scrollview (The middle, something like the bubbles)
    //The _firstScrollView moves alot quciker than this
    _secondScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [_secondScrollView setContentSize:CGSizeMake(1809, 1024)];   // 4 6 was 3072, 1028
    [_secondScrollView setPagingEnabled:TRUE];
    [self.view addSubview:_secondScrollView];
    
    // create third scrollview (on top)
    _thirdScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
    [_thirdScrollView setContentSize:CGSizeMake(1536, 320)]; //  2 3
    
    // the UIScrollView on top gets the delegate and controls the scrolling of the
    // underlying scrollviews
    // UI menu Buttons and labels go here
    [_thirdScrollView setDelegate:self];
    [_thirdScrollView setPagingEnabled:TRUE];
    [self.view addSubview:_thirdScrollView];
    
    
    //LABELS -----------
    UIFont *raleway = [UIFont fontWithName:@"Raleway" size:60];
    //Label
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 200, 1000, 200)];
    titleLabel.text = @"SCRUBBLES";
    titleLabel.textColor = [UIColor blueColor];
    [titleLabel setFont:[UIFont fontWithName:@"Raleway" size:80]];
    [_thirdScrollView addSubview:titleLabel];
    
    titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(768+230, 300, 800, 44.0)];
    titleLabel2.text = @"How to Play";
    titleLabel2.textColor = [UIColor blueColor];
    [titleLabel2 setFont:[UIFont fontWithName:@"Raleway" size:50]];
    [_thirdScrollView addSubview:titleLabel2];
    
    //Play button
    
    playButton = [[UIButton alloc] initWithFrame:CGRectMake(-120, 300, 1000, 200)];
    [playButton setTitle:@"PLAY GAME" forState:UIControlStateNormal];
    // [play]
    //playButton.titleLabel.text = @"Play abc";
    [playButton.titleLabel setFont:[UIFont fontWithName:@"Raleway" size:50]];
    playButton.titleLabel.textColor = [UIColor blueColor];
    
    [playButton addTarget:self action:@selector(transitionToGame:) forControlEvents:UIControlEventTouchUpInside];
    
    //[playButton setFont:[UIFont fontWithName:@"Helvetica Neue" size:80]];
    [_thirdScrollView addSubview:playButton];
    
    
    // load image into first scrollview
    NSString *fileLocation = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"menuBackground.png"];
    UIImage *aImage = [[UIImage alloc] initWithContentsOfFile:fileLocation];
    UIImageView *aImageView = [[UIImageView alloc] initWithImage:aImage];
    aImageView.frame = CGRectMake(-769, 0, aImage.size.width, aImage.size.height);
    printf("%f  %f\n",aImage.size.width, aImage.size.height);
    [_firstScrollView addSubview:aImageView];
    
    
    
    //middleGround
    fileLocation = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"middleGround.png"];
    aImage = [[UIImage alloc] initWithContentsOfFile:fileLocation];
    aImageView = [[UIImageView alloc] initWithImage:aImage];
    aImageView.frame = CGRectMake(-50, 0, aImage.size.width, aImage.size.height);
    //printf("%f  %f",aImage.size.width, aImage.size.height);
    [_secondScrollView addSubview:aImageView];
    
    ///[self.view addSubview:self];
    //[parallaxView setDelegate:self];
    
    
    
}

- (void) transitionToGame:(id)sender
{
    [self performSegueWithIdentifier:@"startGame" sender:self];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // [self clearAllViews];
    
    NSLog(@"scrollhere");
    //NSLog(@"Content offset x: %f", scrollView.contentOffset.x);
    //NSLog(@"Content offset y: %f", scrollView.contentOffset.y);
    
    float speedFactorFirst = 2.5f;
    
    float speedFactorSecond = _secondScrollView.contentSize.width / scrollView.contentSize.width;
    
    speedFactorSecond = 1.9f;
    //NSLog(@"speedfactor y: %f", speedFactorSecond);
    // setting the x value of the contentOffset of the underlying scrollviews
    [_firstScrollView setContentOffset:CGPointMake(speedFactorFirst * scrollView.contentOffset.x, 0)];
    [_secondScrollView setContentOffset:CGPointMake(speedFactorSecond * scrollView.contentOffset.x, 0)];
    
}


//Transition to the new screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Configure the view.
    NSLog(@"here");
    
}



@end
