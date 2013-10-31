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
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        
        myLabel.text = @"Click To Start";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
<<<<<<< HEAD
    
    //SKAction *flyingStart = [SKAction moveByX:600 y:0 duration:40];   //scrolling background
    //[_background runAction:[SKAction repeatActionForever:flyingStart]];
    
    //Speech stuff
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Prepare to play"]];
    
    return self;
    
}

-(SKSpriteNode *) createP1 {
    //Player 1 graphic
    SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"player2.png"];
    player1.position = CGPointMake(CGRectGetMidX(self.frame), 75);
    [player1 runAction:[SKAction scaleBy:.7 duration:.1]];      //Scalling the image because Steve thinks its too big
    player1.name = @"player1";
    
    
    //Player one score
    player1Score = [SKLabelNode labelNodeWithFontNamed:@"player1Score"];
    player1Score.text = @"Player 1 : 100";
    player1Score.fontSize = 20;
    player1Score.position = CGPointMake(60, 10);
    [self addChild:player1Score];
    
    return player1;
    
}

-(void) createObjectB {
    float randX = arc4random_uniform(768) + 5;
    CGPoint startPoint = CGPointMake(randX, CGRectGetMaxY(self.frame));
    SKSpriteNode *enemyBoulder = [SKSpriteNode spriteNodeWithImageNamed:@"dodgeItem.png"];
    enemyBoulder.position = CGPointMake(startPoint.x, startPoint.y);
    enemyBoulder.name = @"enemyBoulder";
    enemyBoulder.color = [SKColor colorWithRed:(rand()*2) green:(rand()*2) blue:(rand()*2) alpha:1];
    enemyBoulder.colorBlendFactor = .5;
    
    //rotating action
    //Picture needs to be fixed so it rotates properly, or the achor point is changed.
    SKAction *rotateBy360 =[SKAction rotateByAngle:degToRad(-10.0f) duration:0.1];
    [enemyBoulder runAction:[SKAction repeatActionForever:rotateBy360]];
    
    
    [self addChild:enemyBoulder];       //adding to background
    
    float randomNum = arc4random_uniform(1) + 1;
    [self performSelector:@selector(createObjectB) withObject:nil afterDelay:randomNum];
}

-(void)update:(CFTimeInterval)currentTime {
    SKNode* player1 = [ self childNodeWithName:(@"player1")];
    
    float ranY = arc4random_uniform(35) + 5;
    /* Called before each frame is rendered */
    
    [self enumerateChildNodesWithName:@"enemyBoulder" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < 0 || node.position.y < 0)
        {
            [node removeFromParent];
        }
        else {
            node.position = CGPointMake(node.position.x, node.position.y - ranY);
            
            }
        
        if ( [player1 intersectsNode:node])
        {
            NSLog(@"Intersection");
            //[self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Plus 1"]]; //make function for this later
            
            [node removeFromParent];      //removing node from parent if collided
            p1scoreInt--;
            player1Score.text = [NSString stringWithFormat:@"Player 1: %i", p1scoreInt];
            
        }
    }];
=======
    return self;
>>>>>>> collisionGroups
}

//Transition to the new screen
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *gameScene = [[Gameplay alloc] initWithSize:self.size];
    SKTransition *doors = [SKTransition doorsOpenHorizontalWithDuration:(0.5)];
    [self.view presentScene:gameScene transition: doors];

}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
