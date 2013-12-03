//
//  ViewController.h
//  basicGame
//

//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface ViewController : UIViewController
{
    
    UIScrollView *_firstScrollView;
    UIScrollView *_secondScrollView;
    UIScrollView *_thirdScrollView;
    UILabel *titleLabel;
    UILabel *titleLabel2;
    UIButton *playButton;
    UIView* parallaxView;
}

@end