//
//  Gameplay.m
//  basicGame
//
//  Created by Stephen  on 10/31/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "Gameplay.h"
#import "Player.h"
#import "PowerNodes.h"

#import <AVFoundation/AVFoundation.h>

#define backgroundColour = [UIColor colorWithRed:8/255.0f green:9/255.0f blue:236/255.0f alpha:1.0f];

@interface Gameplay () <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
//@property (nonatomic,strong)

@end

@implementation Gameplay

static const uint32_t player1_clsn  = 0x1 << 0;
static const uint32_t player2_clsn  = 0x1 << 1;
static const uint32_t nodes1_clsn   = 0x1 << 2;
static const uint32_t nodes2_clsn   = 0x1 << 3;
static const uint32_t powerups      = 0x1 << 4;


int healthAmount = 0;
int p1scoreInt = 100;      //Player 1 score count
SKLabelNode *player1Score;
SKLabelNode *player2Score;
Player *player1;
Player *player2;
PowerNodes *powerNode;
float boulderVelocity = 1024.0/(60.0/100.0);
int bpm = 100;
float boulderCreationDelay;

//Colour constants


/*
 
 ======================= INITIALIZATION METHODS ===========================
 
 */

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
        
        //Music Matching
        boulderCreationDelay = [self setBoulderCreationDelay];
        
        
        
    }
    
    //SKAction *flyingStart = [SKAction moveByX:600 y:0 duration:40];   //scrolling background
    //[_background runAction:[SKAction repeatActionForever:flyingStart]];
    
    //Speech stuff
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utter = [AVSpeechUtterance speechUtteranceWithString:@"Prepare to play, Faggot"];
    utter.rate = 0.4; // ranges between 0 and 1
    utter.pitchMultiplier = 2.0;
    
    
    //[self.synthesizer speakUtterance:utter];
    
    return self;
    
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
    //Background
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;

    //SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"gameBackground.png"];
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithRed:113/255.0f green:209/255.0f blue:236/255.0f alpha:1.0f]
                                                            size:screenSize];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    //[self addChild: [self createP1]];
    
    //Players
    [self createPlayers];
    
    //Huds
    [self createHuds];
    
    
    //Music
    SKAction* soundAction = [SKAction playSoundFileNamed:@"100bpm.mp3" waitForCompletion:YES];
    SKAction* soundActionLoop = [SKAction repeatActionForever: soundAction];
    [self runAction:soundActionLoop];
    
    //Enemy Nodes
    [self performSelector:@selector(createEnemyNodes) withObject:nil afterDelay:0.0];
    [self createPulse];
    
    //PowerNodes
    [self createPowerNodes];
    
    
}


/*
 
 ======================= CREATION METHODS ===========================
 
 */

-(void) createPlayers {
    //Player 1
    player1 = [[Player alloc] initPlayer:1
                            withPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+100)
                               withImage: @"player2.png"];
    
    //SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"player2.png"];
    [self addToCollisionGroup:player1: @"player1"];
    [self addChild:player1];
    
    
    //Player2
    player2 = [[Player alloc] initPlayer:2
                            withPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                     CGRectGetMaxY(self.frame)-100)
                               withImage:@"player2"];
    
    [self addToCollisionGroup:player2: @"player2"];
    [self addChild:player2];
    
}

-(void) createPowerNodes {
     NSString *imageName;
    float randX = arc4random_uniform(768) + 5;
    float randY = arc4random_uniform(768) + 5;
    float imageRand = arc4random_uniform(75)+3;
    if (imageRand < 35) {
        
        //if = 1 + 5
        imageRand = 3;
        imageName = @"3.png";
        healthAmount = 5;
        //if = 0 -5
        
    }
    
    else {
        imageRand = 4;
        imageName = @"4.png";
        healthAmount = -5;
    }
   


    powerNode = [[PowerNodes alloc] initPlayer:3
                                  withPosition:CGPointMake(randX, randY) withImage:imageName];
    
    powerNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:powerNode.size.width/10];
    powerNode.physicsBody.dynamic = YES;
    
    powerNode.physicsBody.affectedByGravity = NO;
    powerNode.physicsBody.linearDamping = 0.0;
    powerNode.physicsBody.angularDamping = 0.0;
    
    //Initial Velocty
    powerNode.physicsBody.velocity = CGVectorMake(0,-1);
    [self addToCollisionGroup:powerNode: @"powerNode"];
    [self addChild:powerNode];
    
    
    
    
}
-(void) createHuds{
    
    //Hud1
    SKNode * hud1 = [SKNode node];
    hud1.name = @"hud1";
    
    //Hud2
    SKNode * hud2 = [SKNode node];
    hud2.name = @"hud2";

    
    //Player one score
    player1Score = [SKLabelNode labelNodeWithFontNamed:@"player1Score"];
    player1Score.text = @"Player 1 : 100";
    player1Score.fontSize = 20;
    player1Score.position = CGPointMake(CGRectGetMinX(self.frame)+100,
                                        CGRectGetMaxY(self.frame)-100);
    [hud1 addChild:player1Score];
    
    //Player two score
    player2Score = [SKLabelNode labelNodeWithFontNamed:@"player2Score"];
    player2Score.text = @"Player 2 : 100";
    player2Score.fontSize = 20;
    player2Score.position = CGPointMake(CGRectGetMaxX(self.frame)-100,
                                        CGRectGetMinY(self.frame)+100);
    [hud2 addChild:player2Score];
    
    [self addChild:hud1];
    [self addChild:hud2];
    SKAction *oneRevolution = [SKAction rotateByAngle:-M_PI duration:0];
    SKAction *move1= [SKAction moveToY:(CGRectGetMidY(self.frame)+100) duration:0];
    SKAction *move2= [SKAction moveToX:(CGRectGetMaxX(self.frame)+560) duration:0];
    SKAction *test = [SKAction sequence:@[move1, move2,oneRevolution]];
    [hud2 runAction:test];
//    [hud2 runAction:oneRevolution];
 
    
//    [player2Score runAction:oneRevolution];
}


-(void) createEnemyNodes {
    float randX = arc4random_uniform(768) + 5;
    CGPoint startPoint = CGPointMake(randX, CGRectGetMaxY(self.frame));
    SKSpriteNode *enemyNode = [SKSpriteNode spriteNodeWithImageNamed:@"enemyNode2.png"];
    enemyNode.xScale= 0.1;
    enemyNode.yScale= 0.1;
    enemyNode.position = CGPointMake(startPoint.x, startPoint.y);
    
    enemyNode.name = @"enemyNode";
    //enemyNode.color = [SKColor colorWithRed:(rand()*2) green:(rand()*2) blue:(rand()*2) alpha:1];
    //enemyNode.colorBlendFactor = .5;
    
    //rotating action
    //Picture needs to be fixed so it rotates properly, or the achor point is changed.
    //SKAction *rotateBy360 =[SKAction rotateByAngle:degToRad(-10.0f) duration:0.1];
    //[enemyNode runAction:[SKAction repeatActionForever:rotateBy360]];
    
    
    //Give the ball some physics
    enemyNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:enemyNode.size.width/10];
    enemyNode.physicsBody.dynamic = YES;
    
    enemyNode.physicsBody.affectedByGravity = NO;
    enemyNode.physicsBody.linearDamping = 0.0;
    enemyNode.physicsBody.angularDamping = 0.0;
    
    //Initial Velocty
    enemyNode.physicsBody.velocity = CGVectorMake(0,-boulderVelocity);
    
    // collision
    [self addToCollisionGroup:enemyNode: @"enemyNode1"];
    
    [self addChild:enemyNode];       //adding to background
    
    [self performSelector:@selector(createEnemyNodes) withObject:nil afterDelay:boulderCreationDelay];
}

-(float)setBoulderCreationDelay
{
    float secPerBeat = 60.0/bpm;
    float timeToTravelScreen =(CGRectGetMaxY(self.frame)/boulderVelocity);
    return (secPerBeat + timeToTravelScreen)/2.0;
    
}


-(void) addToCollisionGroup: (SKSpriteNode*) Node : (NSString*) group{
    if ( [group isEqualToString:@"player1"]){
        Node.physicsBody.categoryBitMask = player1_clsn;
        Node.physicsBody.collisionBitMask = 0;//nodes1_clsn;
        Node.physicsBody.contactTestBitMask = nodes1_clsn;
        
    }
    else if ([group isEqualToString:@"player2"]) {
        Node.physicsBody.categoryBitMask = player2_clsn;
        Node.physicsBody.collisionBitMask = 0;//nodes2_clsn;
        Node.physicsBody.contactTestBitMask = nodes2_clsn;
    }
    else if ([group isEqualToString:@"enemyNode1"]) {
        Node.physicsBody.categoryBitMask = nodes1_clsn;
        Node.physicsBody.collisionBitMask = 0;//player1_clsn;
        Node.physicsBody.contactTestBitMask = player1_clsn;
    }
    else if ([group isEqualToString:@"enemyNode2"]) {
        Node.physicsBody.categoryBitMask = nodes2_clsn;
        Node.physicsBody.collisionBitMask = 0;//player2_clsn;
        Node.physicsBody.contactTestBitMask = player2_clsn;
    }
    else if ([group isEqualToString:@"powerNode"]) {
        Node.physicsBody.categoryBitMask = powerups;
        Node.physicsBody.collisionBitMask = player1_clsn | player2_clsn;
        Node.physicsBody.contactTestBitMask = player1_clsn | player2_clsn;
    }
    
    
}



-(SKSpriteNode *) createP1 {
    //Player 1 graphic
    SKSpriteNode *player1 = [SKSpriteNode spriteNodeWithImageNamed:@"player2.png"];
    
    //player1 = [[Player alloc] init:(int*)1];
    
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

-(void)createPulse{
    
    CGPoint startPoint = CGPointMake(CGRectGetMinX(self.frame)+100, CGRectGetMidY(self.frame));
    SKSpriteNode *pulseBoulder = [SKSpriteNode spriteNodeWithImageNamed:@"dodgeItem.png"];
    pulseBoulder.position = CGPointMake(startPoint.x, startPoint.y);
    pulseBoulder.name = @"enemyNode";
    pulseBoulder.color = [SKColor colorWithRed:(rand()*2) green:(rand()*2) blue:(rand()*2) alpha:1];
    [self addChild:pulseBoulder];       //adding to background
    //PULSE CODE
    SKAction *delay = [SKAction waitForDuration:(boulderCreationDelay-0.2)];
    SKAction *grow = [SKAction scaleBy: 1.4 duration:0.1];
    SKAction *shrink = [SKAction scaleBy:0.7142857  duration:0.1];
    SKAction *pulse = [SKAction sequence:@[grow, shrink,delay]];
    //SKAction *pulse = [SKAction sequence:@[grow]];
    SKAction* pulseLoop = [SKAction repeatActionForever: pulse];
    
    [pulseBoulder runAction:pulseLoop];
    
}




/*
 
 ======================= GAMEPLAY METHODS ===========================
 
 */

-(void)update:(CFTimeInterval)currentTime {
    
    //Remove nodes out of the screen
    [self enumerateChildNodesWithName:@"enemyNode" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < 0 || node.position.y < 0)
        {
            [node removeFromParent];
        }
        if (node.position.x > CGRectGetMaxX(self.frame) || (node.position.y > CGRectGetMaxY(self.frame))){
            [node removeFromParent];
        }
    }];
}

//Collision Detection
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
    
    if ((secondBody.categoryBitMask & nodes1_clsn) != 0){
        NSLog(@"sup1 %u\n", secondBody.categoryBitMask);
                NSLog(@"sup1 %u\n", firstBody.categoryBitMask);
        NSLog(@"sup2 %u", nodes1_clsn);
        NSLog(@"sup3 %u", nodes2_clsn);
        NSLog(@"Sup4 %u",secondBody.categoryBitMask & nodes1_clsn);
        NSLog(@"Sup5 %u",secondBody.categoryBitMask & nodes2_clsn);
    }
    
    
    //Did collide with player1
    if ((firstBody.categoryBitMask & player1_clsn) !=0 && (secondBody.categoryBitMask & nodes1_clsn) != 0) {
//        NSLog(@"Intersection %u",(firstBody.categoryBitMask & player1_clsn) );
        //[self.synthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Plus 1"]]; //make function for this later
        SKAction* soundAction = [SKAction playSoundFileNamed:@"hit1.mp3" waitForCompletion:NO];
        [self runAction:soundAction];
        [secondBody.node removeFromParent];      //removing node from parent if collided
        [player1 decreaseHealth:1];
        [self updateScore:player1Score: player1.getHealth];
        
    }
    
    //Did collide with player2
    if ((firstBody.categoryBitMask & player2_clsn) !=0 && (secondBody.categoryBitMask & nodes2_clsn)!=0)
    {
//        NSLog(@"Intersection %u",(firstBody.categoryBitMask & player2_clsn));
//        NSLog(@"Intersection/ %u",(secondBody.categoryBitMask & nodes2_clsn));
        SKAction* soundAction = [SKAction playSoundFileNamed:@"hit1.mp3" waitForCompletion:NO];
        [self runAction:soundAction];
        [secondBody.node removeFromParent];      //removing node from parent if collided
        
        [player2 decreaseHealth:1];
        [self updateScore:player1Score: player2.getHealth];
    }
    
    
    
     if ((secondBody.categoryBitMask & powerups) !=0) {
         if ((firstBody.categoryBitMask & player1_clsn)!=0){
             [powerNode removeFromParent];
             [player1 increaseHealth:healthAmount];
             [self updateScore:player1Score: player1.getHealth];
         }
    
    
    
        if ((firstBody.categoryBitMask & player2_clsn)!=0)                                                                                                                                                                                                                                                                                                              
        {
            [powerNode removeFromParent];
        }
    
    }

}


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
        if([[touchedNode name] isEqualToString:@"player2"]) {
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-8.0f) duration:0.1],
													  [SKAction rotateByAngle:0.0 duration:0.1],
													  [SKAction rotateByAngle:degToRad(8.0f) duration:0.1]]];
			[_selectedNode runAction:[SKAction repeatActionForever:sequence]];
            //[_selectedNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:degToRad(-10.0f) duration:0.1]]];
		}
    }
	
    
}


/*
 
 ======================= MOVEMENT METHODS ===========================
 
 */

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
    //Change to incorporate 2nd player
    
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
