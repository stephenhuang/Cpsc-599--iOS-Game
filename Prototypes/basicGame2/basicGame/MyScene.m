//
//  MyScene.m
//  Game Prototypes
//
//  Created by Stephen  on 2013-10-17.
//  Copyright (c) 2013 Stephen . All rights reserved.
//

#import "MyScene.h"
#import "Gameplay.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        // Override point for customization after application launch.
        //GRAND CENTRAL DISPATCH
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        
        dispatch_group_async(group, queue, ^{
           audioplayer = [[AudioManager alloc] init];

        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            //Update the state of the scene

            
            SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
            
            myLabel.text = @"Click To Start";
            myLabel.fontSize = 30;
            myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame));
            
            [self addChild:myLabel];
        });
        

    }
    return self;

}

//Transition to the new screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *gameScene = [[Gameplay alloc] initWithSize:self.size andAudio:audioplayer];
    SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:(0.5)];
    [self.view presentScene:gameScene transition: doors];

}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
