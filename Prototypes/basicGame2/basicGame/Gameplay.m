//
//  Gameplay.m
//  basicGame
//
//  Created by Stephen  on 10/31/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "Gameplay.h"

#import <AVFoundation/AVFoundation.h>

int p1scoreInt = 100;      //Player 1 score count

@interface Gameplay ()

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@end

@implementation Gameplay

static const uint32_t player1 = 0x1 << 0;
static const uint32_t enemyNodesCategory   = 0x1 << 1;
static const uint32_t extra   = 0x1 << 2;
SKLabelNode *player1Score;
float boulderVelocity = 1024.0/(60.0/100.0);
int bpm = 100;
float boulderCreationDelay;


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        

        //SKAction* soundAction = [SKAction playSoundFileNamed:@"test1.wav" waitForCompletion:YES];
        //SKAction* soundAction = [SKAction playSoundFileNamed:@"80bpm_simple_drum.mp3" waitForCompletion:YES];
        
        //SKAction* soundActionLoop = [SKAction repeatActionForever: soundAction];
        //[self runAction:soundActionLoop];
        
        //Physics
        // Set gravity to zero
        self.physicsWorld.gravity = CGVectorMake(0,0);
        // look for collisions
        self.physicsWorld.contactDelegate = (id)self;
        
        //Beats
        boulderCreationDelay = [self setBoulderCreationDelay];
        
        
    }
    
    //SKAction *flyingStart = [SKAction moveByX:600 y:0 duration:40];   //scrolling background
    //[_background runAction:[SKAction repeatActionForever:flyingStart]];
    
    //Speech stuff
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utter = [AVSpeechUtterance speechUtteranceWithString:@"Prepare to play, Faggot"];
    utter.rate = 0.4; // ranges between 0 and 1
    utter.pitchMultiplier = 2.0;

                               
    [self.synthesizer speakUtterance:utter];
    
    return self;
    
}

-(float)setBoulderCreationDelay
{
    float secPerBeat = 60.0/bpm;
    float timeToTravelScreen =(CGRectGetMaxY(self.frame)/boulderVelocity);
    return (secPerBeat + timeToTravelScreen)/2.0;
    
    
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
        
    }
}
- (void)createSceneContents
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"gameBackground.png"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    [self addChild: [self createP1]];
    SKAction* soundAction = [SKAction playSoundFileNamed:@"100bpm.mp3" waitForCompletion:YES];
    //Create your first boulder
    [self performSelector:@selector(createObjectB) withObject:nil afterDelay:0.0];

    
    SKAction* soundActionLoop = [SKAction repeatActionForever: soundAction];
    [self runAction:soundActionLoop];
}

-(void) addToCollisionGroup: (SKSpriteNode*) Node : (NSString*) group{
    if ( [group isEqualToString:@"player1"]){
        Node.physicsBody.categoryBitMask = player1;
        Node.physicsBody.collisionBitMask = enemyNodesCategory;
        Node.physicsBody.contactTestBitMask = enemyNodesCategory;
        
    }
    else if ([group isEqualToString:@"Boulder1"]) {
        //Collision Groups
        Node.physicsBody.categoryBitMask = enemyNodesCategory;
        Node.physicsBody.collisionBitMask = player1;
        Node.physicsBody.contactTestBitMask = player1;
    }
}

-(SKSpriteNode *) createP1 {
    //Player 1 graphic
    SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"player2.png"];
    player1.position = CGPointMake(CGRectGetMidX(self.frame), 75);
    player1.name = @"player1";
    
    //Add Physics
    player1.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:player1.size];
    player1.physicsBody.dynamic = NO;
    [self addToCollisionGroup:player1: @"player1"];
    
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
     [self addToCollisionGroup:enemyBoulder: @"Boulder1"];
    
    //rotating action
    //Picture needs to be fixed so it rotates properly, or the achor point is changed.
    //SKAction *rotateBy360 =[SKAction rotateByAngle:degToRad(-10.0f) duration:0.1];
    //[enemyBoulder runAction:[SKAction repeatActionForever:rotateBy360]];
    
    
    //Give the ball some physics
    enemyBoulder.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:enemyBoulder.size.width/10];
    enemyBoulder.physicsBody.dynamic = YES;
    
    enemyBoulder.physicsBody.affectedByGravity = NO;
    enemyBoulder.physicsBody.linearDamping = 0.0;
    enemyBoulder.physicsBody.angularDamping = 0.0;
    //Initial Velocty
    enemyBoulder.physicsBody.velocity = CGVectorMake(0,-boulderVelocity);
    

    
    [self addChild:enemyBoulder];       //adding to background
    
    [self performSelector:@selector(createObjectB) withObject:nil afterDelay:boulderCreationDelay];
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
           // node.position = CGPointMake(node.position.x, node.position.y - ranY);
           // node.physicsBody.velocity = CGVectorMake(0,-boulderVelocity);
            
        }
        /*
        if ( [player1 intersectsNode:node])
        {
            NSLog(@"Intersection");
            //[self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Plus 1"]]; //make function for this later
            
            [node removeFromParent];      //removing node from parent if collided
            
            //p1scoreInt--;
            [self updateScore:player1Score: p1scoreInt--];
            //player1Score.text = [NSString stringWithFormat:@"Player 1: %i", p1scoreInt];
            
        }
         */
    }];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    //Who hit who?
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & enemyNodesCategory) !=0){
        
    }
    //Did collide with player
    if ((firstBody.categoryBitMask & player1) !=0)
    {
        NSLog(@"Intersection");
        //[self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Plus 1"]]; //make function for this later
        
        [secondBody.node removeFromParent];      //removing node from parent if collided
        
        //p1scoreInt--;
        [self updateScore:player1Score: p1scoreInt--];
        //player1Score.text = [NSString stringWithFormat:@"Player 1: %i", p1scoreInt];

        //[self updateLabel];
    }
    
}
//Add player nodes as well
-(void) updateScore: (SKLabelNode*) label : (int) score
{
    NSString *countString = [NSString stringWithFormat:@"Player 1: %i", score];
    [label setText: countString];
    
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
