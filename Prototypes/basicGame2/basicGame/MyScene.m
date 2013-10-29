//
//  MyScene.m
//  basicGame
//
//  Created by Robert Siry on 2013-10-25.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "MyScene.h"
#import <AVFoundation/AVFoundation.h>

int p1scoreInt = 100;      //Player 1 score count

@interface MyScene ()

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;


@end

@implementation MyScene{
SKLabelNode *player1Score;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"gameBackground.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        [self addChild: [self createP1]];
        [self performSelector:@selector(createObjectB) withObject:nil afterDelay:0.0];
        SKAction* soundAction = [SKAction playSoundFileNamed:@"test1.wav" waitForCompletion:YES];
        
        SKAction* soundActionLoop = [SKAction repeatActionForever: soundAction];
        [self runAction:soundActionLoop];
    }
    
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
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    //NSLog(@"selected node = %s", touchedNode.name);       //Debug the selected node
    
    //2
	if(![_selectedNode isEqual:touchedNode]) {
		[_selectedNode removeAllActions];
		[_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		_selectedNode = touchedNode;
		//3
		if([[touchedNode name] isEqualToString:@"player1"]) {
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-8.0f) duration:0.1],
													  [SKAction rotateByAngle:0.0 duration:0.1],
													  [SKAction rotateByAngle:degToRad(8.0f) duration:0.1]]];
			[_selectedNode runAction:[SKAction repeatActionForever:sequence]];
            //[_selectedNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:degToRad(-10.0f) duration:0.1]]];
		}
	}
    
}
float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[_background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
	[self panForTranslation:translation];
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:@"player1"]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
    
    //Needs cleaning up, copied code from Rob's Project
}

- (void)sayThis:(NSString*)text
{
    //This method will be used for speechSynthesis.
    //But I wanna play some CS
    NSLog(text);
}

@end
