//
//  Gameplay.m
//  basicGame
//
//  Created by Stephen  on 10/31/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "Gameplay.h"
#import "GameOverScene.h"
#import <AVFoundation/AVFoundation.h>
#import "BattleViewController.h"

#define backgroundColour = [UIColor colorWithRed:8/255.0f green:9/255.0f blue:236/255.0f alpha:1.0f];

@interface Gameplay () <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@property (nonatomic)         float startTime;
@property (nonatomic, strong) GameTimer* gameTimer;
@property (nonatomic)         float stageOfGame;
@property (nonatomic)         float enemyOpacityRatio; //The rate the opacity changes
@property (nonatomic)         Boolean powerupActive;
@property (nonatomic)         Boolean gameOver;


@end

@implementation Gameplay
{
    BattleViewController * _battle;
    GameOverScene *_gameOverScene;
    SKTransition *doors;
    NSMapTable * _touchToNodeLookup;
}

static const uint32_t player1_clsn  = 0x1 << 0;
static const uint32_t player2_clsn  = 0x1 << 1;
static const uint32_t nodes1_clsn   = 0x1 << 2;
static const uint32_t nodes2_clsn   = 0x1 << 3;
static const uint32_t powerups      = 0x1 << 4;
//May not need
static const uint32_t nodes1_power  = 0x1 << 5;
static const uint32_t nodes2_power  = 0x1 << 6;



SKLabelNode *player1Score;
SKLabelNode *player2Score;
Player *player1;
Player *player2;
//PowerNodes *powerNode;


int healthAmount = 0;
//float boulderVelocity = 1024.0/(60.0/100.0);
//float boulderVelocity = 200;
float boulderVelocity = 800;

int bpm = 800;
float boulderCreationDelay;

float imageRand = 0;
bool isPaused = false;
//Colour constants


/*
 
 ======================= 0. INITIALIZATION METHODS ===========================
 
 */

//MUSIC////////////////////////////////////////
- (IBAction)stopMusic
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.myAudioPlayer stop];
    
}


- (IBAction)startMusic
{
    [AudioPlayer playBaseBeat];
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    //[appDelegate.myAudioPlayer play];
}
//////////////////////////////////////////////



-(id)initWithSize:(CGSize)size andAudio:(AudioManager*) audio{
    if (self = [super initWithSize:size]) {
        //Initialize audio player
        AudioPlayer = audio;
        
        //Physics
            // Set gravity to zero
        self.physicsWorld.gravity = CGVectorMake(0,0);
            // look for collisions
        self.physicsWorld.contactDelegate = (id)self;
        
        //GameplayTimer
        _gameTimer =[[GameTimer alloc] init];
        
        //GameplayAttributes
        _stageOfGame = 1;
        _powerupActive = false;
        _gameOver = false;
        
        //Music Matching
        boulderCreationDelay = [self setBoulderCreationDelay];
        
        _touchToNodeLookup = [NSMapTable weakToWeakObjectsMapTable];
        
    }
    
    //Speech stuff
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    AVSpeechUtterance *utter = [AVSpeechUtterance speechUtteranceWithString:@"Prepare to play"];
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
    
    //Players
    [self createPlayers];
    
    //Huds
    [self createHuds];
    
    //Music
    [self startMusic];
    
    //Enemy Nodes
    _enemyOpacityRatio = 1.7;
    [self performSelector:@selector(createEnemyNodes:) withObject:([NSNumber numberWithInt:1]) afterDelay:0.0];
    [self createPulse];
    
    //PowerNodes
    [self createPowerNodes];
    
    

    
    
}


/*
 
 ======================= 1. CREATION METHODS ===========================
 
 */

-(void) createPlayers {
    //Player 1
    player1 = [[Player alloc] initPlayer:1
                            withPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame)+100)
                               withImage: @"playerIcon.png"];
    [self addToCollisionGroup:player1: @"player1"];
    [self addChild:player1];
    
    
    //Player2
    player2 = [[Player alloc] initPlayer:2
                            withPosition:CGPointMake(CGRectGetMidX(self.frame),
                                                     CGRectGetMaxY(self.frame)-100)
                               withImage:@"playerIcon.png"];
    
    [self addToCollisionGroup:player2: @"player2"];
    [self addChild:player2];
    
    
}

-(void) createHuds{
    UIColor * lineColor = [UIColor colorWithRed:243/255.0f green:256/255.0f blue:255/255.0f alpha:1.0f];
    SKSpriteNode * middleLine = [SKSpriteNode spriteNodeWithColor:lineColor size:CGSizeMake(CGRectGetMaxX(self.frame), 2)];
    middleLine.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
    middleLine.alpha = 0.5;
    [self addChild:middleLine];
    
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
                                        CGRectGetMidY(self.frame)-100);
    [hud1 addChild:player1Score];
    
    //Player two score
    player2Score = [SKLabelNode labelNodeWithFontNamed:@"player2Score"];
    player2Score.text = @"Player 2 : 100";
    player2Score.fontSize = 20;
    player2Score.position = CGPointMake(CGRectGetMaxX(self.frame)+100,
                                        CGRectGetMidY(self.frame)-100);
    [hud2 addChild:player2Score];
    
    [self addChild:hud1];
    [self addChild:hud2];
    
    SKAction *oneRevolution = [SKAction rotateByAngle:-M_PI duration:0];
    SKAction *move1= [SKAction moveToY:(CGRectGetMidY(self.frame)+500) duration:0];
    SKAction *move2= [SKAction moveToX:(CGRectGetMaxX(self.frame)+760) duration:0];
    SKAction *flipHud = [SKAction sequence:@[move1, move2,oneRevolution]];
    [hud2 runAction:flipHud];

}


// -------------
-(void) createEnemyNodes:(NSNumber*) playerNumber {

    int playerNum = [playerNumber intValue];
    if (!_powerupActive){
    SKSpriteNode *enemyNode;
    CGPoint startPoint;
    int direction;
    
    float randX = arc4random_uniform(768) + 5;
    
    
    //Player specific attributes
    if (playerNum == 1){
        enemyNode = [SKSpriteNode spriteNodeWithImageNamed:@"enemyNode1.png"];
        enemyNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:enemyNode.size.width/10];
        
        startPoint = CGPointMake(randX, CGRectGetMaxY(self.frame));
        direction = -1;
        [self addToCollisionGroup:enemyNode: @"enemyNode1"];
    }
    
    else{
        enemyNode = [SKSpriteNode spriteNodeWithImageNamed:@"enemyNode2.png"];
        enemyNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:enemyNode.size.width/10];
        
        startPoint = CGPointMake(randX, CGRectGetMinY(self.frame));
        direction = 1;
        [self addToCollisionGroup:enemyNode: @"enemyNode2"];
  
    }
    
    //Set Properties
    enemyNode.xScale= 0.1;
    enemyNode.yScale= 0.1;
    enemyNode.name = @"enemyNode";
    enemyNode.position = CGPointMake(startPoint.x, startPoint.y);
    enemyNode.alpha = 0.1;
    
    //Give the ball some physics

    enemyNode.physicsBody.velocity = CGVectorMake(0,boulderVelocity*direction);
    enemyNode.physicsBody.dynamic = YES;
    enemyNode.physicsBody.affectedByGravity = NO;
    enemyNode.physicsBody.linearDamping = 0.0;
    enemyNode.physicsBody.angularDamping = 0.0;
    enemyNode.physicsBody.mass = 1;
    enemyNode.physicsBody.density = 1;
    

    [self addChild:enemyNode];       //adding to background
    
    }
    if (!_gameOver){
        if (playerNum ==1){
            [self performSelector:@selector(createEnemyNodes:) withObject:[NSNumber numberWithInt:2] afterDelay:0];
        }
        else{
            [self performSelector:@selector(createEnemyNodes:) withObject:[NSNumber numberWithInt:1] afterDelay:boulderCreationDelay];
        }
    }
    
    

   
}



-(void) createPowerNodes{

    PowerNodes *powerNode = [[PowerNodes alloc] init];

    [self addToCollisionGroup:powerNode: @"powerNode"];
    [self addChild:powerNode];
    if (!_gameOver){
        [self performSelector:@selector(createPowerNodes) withObject:nil afterDelay:10];
    }
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
        Node.physicsBody.collisionBitMask = player1_clsn;
        Node.physicsBody.contactTestBitMask = player1_clsn;
    }
    else if ([group isEqualToString:@"enemyNode2"]) {
        Node.physicsBody.categoryBitMask = nodes2_clsn;
        Node.physicsBody.collisionBitMask = player2_clsn;
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
 
 ======================= 3. GAMEPLAY METHODS ===========================
 
 */

-(void)update:(CFTimeInterval)currentTime {
   // NSLog(@"time: %f", currentTime);

    //Remove nodes out of the screen
    [self enumerateChildNodesWithName:@"enemyNode" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < 0 || node.position.y < 0)
        {
            [node removeFromParent];
        }
        if (node.position.x > CGRectGetMaxX(self.frame) || (node.position.y > CGRectGetMaxY(self.frame))){
            [node removeFromParent];
        }
        
        //Change Node Opacity
        //Is it node 1?
        if((node.physicsBody.categoryBitMask & nodes1_clsn) != 0){
            node.alpha = [self determineNodeOpacity: node.position.y withDirection:-1];
            
        }
        if((node.physicsBody.categoryBitMask & nodes2_clsn) != 0){
            node.alpha =[self determineNodeOpacity: node.position.y withDirection:1];
        }
    
        
    }];
    
    

    //Determine Game
    if ([player1 getHealth] <= 0){
        [self endGame:1: player1.getHealth: player2.getHealth];
    }
    if ([player2 getHealth] <= 0){
        [self endGame:2:player1.getHealth: player2.getHealth];
    }
    
    if(!isPaused)
    {
        [self increaseDifficulty];
    }
    else
        printf("Paused");

}

-(void)increaseDifficulty{
    //Speed up enemy
    if (_stageOfGame != [_gameTimer getDifficulty]){
        
//        NSLog(@"\n");
//        NSLog(@"speed: %f ", boulderCreationDelay);
//        NSLog(@"ratio: %f ", _enemyOpacityRatio);
//        NSLog(@"stage: %f ", _stageOfGame);
        
        _stageOfGame =[_gameTimer getDifficulty];
        if (![_gameTimer creationThresholdPassed:_stageOfGame]){
            float delayIncrease = 1.0/(1.0 - (1.0/_stageOfGame));
            boulderCreationDelay/=delayIncrease;

        }
        //Passed the threshold. Time to speed it up
        else{
            if (![_gameTimer speedThresholdPassed:_stageOfGame]){
                if (_enemyOpacityRatio >0.2){
                    _enemyOpacityRatio-= 0.05;
                }
                boulderVelocity +=60;
            }
            //Increase boulder count again
            else{
                float delayIncrease = 1.0/(1.0 - (1.0/_stageOfGame));
                boulderCreationDelay/=delayIncrease;
                
            }
            
        
        }

    }
    

    
}

-(float)determineNodeOpacity:(float) currentPosition withDirection:(int)direction{
    float mid = CGRectGetMidY(self.frame);
    float max = CGRectGetMaxY(self.frame);
    float crossingPoint =0;
    if (direction == -1){
        crossingPoint = max;
    }
    else{
        crossingPoint = 0;
    }
    // See if it's in the other players zone
    if (currentPosition*direction + crossingPoint  < mid ){
        //determine scaling opacity as a ratio of half of the screen
        //return 0.1;
        return(( crossingPoint + currentPosition*direction))/(mid*_enemyOpacityRatio);
    }
    else{
        return 1.0;
    }
    
}


-(void) updateScore: (SKLabelNode*) label : (int) score
{
    NSString *countString = [NSString stringWithFormat:@"Player 1: %i", score];
    [label setText: countString];
    
}





/*
 
 ======================= 4. COLLISION METHODS ===========================
 
 */

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
    
    
    //Did collide with player1

    if ((firstBody.categoryBitMask & player1_clsn) != 0){
     if((secondBody.categoryBitMask & nodes1_clsn) != 0) {
        
         //Regular interaction
        if (!_powerupActive){
            [self runAction:[AudioPlayer getPlayerHitBeat]];
            [secondBody.node removeFromParent];      //removing node from parent if collided
            [player1 decreaseHealth:5];
            [self updateScore:player1Score: player1.getHealth];
         }
        else{
            //Some powerup is active. Everything is different
        }
     }
    }
    
    //Did collide with player2
    if ((firstBody.categoryBitMask & player2_clsn) !=0){
        if ((secondBody.categoryBitMask & nodes2_clsn)!=0){
        //Play sound
        [self runAction:[AudioPlayer getPlayerHitBeat]];
        [secondBody.node removeFromParent];
        
        [player2 decreaseHealth:5];
        [self updateScore:player2Score: player2.getHealth];
        }
     }
    
    
    //Powerups
    if ((secondBody.categoryBitMask & powerups) !=0) {
        [self powerupCollision:firstBody withBody:secondBody];
        
    }
    
}


-(void)powerupCollision: (SKPhysicsBody* ) firstBody withBody: (SKPhysicsBody*) secondBody{
    PowerNodes * powerNode = (PowerNodes *) secondBody.node;
    NSString * powerType = [powerNode getPowerType];

    //Determine powerup type
    if ([powerType isEqualToString:@"healthUp"])
    {
        [self runAction:[AudioPlayer getHealthUpBeat]];
    }
    else if ([powerType isEqualToString:@"healthDown"])
    {
     
        [self runAction:[AudioPlayer gethealthDownBeat]];
    }

    
    if ((firstBody.categoryBitMask & player1_clsn)!=0){
       
        //Send all nodes to the enemy player!
        if ([powerType isEqualToString:@"sendAllNodes"]){
            _powerupActive = true;
            NSTimeInterval fadingTime = 1;
            SKColor *nodeColor = [SKColor redColor];
            
            SKAction *slowNodes = [SKAction runBlock:^{
                self.physicsWorld.gravity = CGVectorMake(0,2);
                
            }];
            
            SKAction *wait = [SKAction waitForDuration: 0.5];
            
            [self enumerateChildNodesWithName:@"enemyNode" usingBlock:^(SKNode *node, BOOL *stop) {
                SKSpriteNode * enemyNode = (SKSpriteNode* )node;
                
                
                
                SKAction * fadeNode = [SKAction fadeAlphaTo:1 duration:fadingTime];
                SKAction * colorNode = [SKAction colorizeWithColor:nodeColor colorBlendFactor:0.7 duration:fadingTime];
                SKAction * colorize = [SKAction group:@[fadeNode, colorNode]];
//                SKAction  *colorNode1 =[SKAction customActionWithDuration:5 actionBlock:^(SKNode* node, CGFloat timeElapsed){
//                    enemyNode.colorBlendFactor = 0.1;
//                    enemyNode.color = [SKColor redColor];
//                    
//                }];

                //Physics!
                
                //enemyNode.physicsBody.velocity = CGVectorMake(0,1);
                CGFloat vy =  enemyNode.physicsBody.velocity.dy;
                CGFloat d = abs(enemyNode.position.y);
                CGFloat a = (pow(vy,2))/(2*d);
                if (d ==0){
                    a = 0;
                }
                
                
                NSLog(@"y: %f", enemyNode.position.y);
                NSLog(@"v: %f",vy);
                NSLog(@"d: %f",d);
                NSLog(@"f: %f",a);
                NSLog(@"\n");
                //a = 10;
                CGVector force = CGVectorMake(0, a);
                //[enemyNode.physicsBody applyForce:force];
                [enemyNode.physicsBody applyImpulse:force];
                //enemyNode.physicsBody.linearDamping = 1;
                //enemyNode.physicsBody.affectedByGravity =YES;
                //enemyNode.alpha =1;
                

                SKAction * sendAllNodes = [SKAction sequence:@[colorize]];
                
                [enemyNode runAction: sendAllNodes];
           }];
        }
        
        [secondBody.node removeFromParent];
        [player1 increaseHealth:healthAmount];
        [self updateScore:player1Score: player1.getHealth];
    }
    
    
    
    if ((firstBody.categoryBitMask & player2_clsn)!=0)
    {
        [secondBody.node removeFromParent];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
    CGPoint positionInScene = [touch locationInNode:self];
        [self selectNodeForTouch:positionInScene touch:touch];
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches)
    {
        [_touchToNodeLookup removeObjectForKey:(touch)];
    }
}

- (void)selectNodeForTouch:(CGPoint)touchLocation touch:(UITouch*)touch
{
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    //NSLog(@"selected node = %s", touchedNode.name);       //Debug the selected node
    
    
    if([touchedNode.name isEqualToString:@"player1"] ||
       [touchedNode.name isEqualToString:@"player2"])
    {
        [touchedNode removeAllActions];
        [touchedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
        [_touchToNodeLookup setObject:touchedNode forKey:touch];
    }
    
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
    if([[touchedNode name] isEqualToString:@"enemyNode"]) {
        //This is a test for the battle menus
        [self pauseGame];
        
    }
    
}

-(void)pauseGame
{
    //REMOVE ME LATER
    [self blurScene];
    


    //Need to pause sound too
    SKView *spriteView = (SKView *) self.view;
    
    if(!spriteView.paused)
    {
        isPaused=true;
        spriteView.paused=YES;
        [AudioPlayer pauseBaseBeat];
        
        //Creating the battle menu
        
        _battle = [[BattleViewController alloc]initWithNibName:@"BattleViewController" bundle:nil];
        //_battle.view.tag =99;
        
        //Old way
//        UIViewController *vc = self.view.window.rootViewController;
//        vc.view.backgroundColor = [UIColor blueColor];
//        [vc presentViewController:battle animated:YES completion:Nil];  //If we keep it, unpause on completion
    
        //Looks great, but doesn't work
        _battle.view.alpha = 0.0;
        [self.scene.view addSubview:_battle.view];
        
        [UIView animateWithDuration:1.0 animations:^{
        
        _battle.view.alpha = 1.0;
        
        }];
    }
    else
    {
        isPaused=false;
        spriteView.paused=NO;
        [AudioPlayer playBaseBeat];
    }
    printf("Done Statements\n");
}


/*
 
 ======================= 5. MOVEMENT METHODS ===========================
 
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
	for (UITouch *touch in touches)
    {
        CGPoint positionInScene = [touch locationInNode:self];
        CGPoint previousPosition = [touch previousLocationInNode:self];
    
        CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
        [self panForTranslation:translation touch:touch];
    }
}

- (void)panForTranslation:(CGPoint)translation touch:(UITouch*)touch {
    SKNode * selectedNode = [_touchToNodeLookup objectForKey:touch];
    CGPoint position = [selectedNode position];
    //Change to incorporate 2nd player
    
    if([[selectedNode name] isEqualToString:@"player1"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
    if([[selectedNode name] isEqualToString:@"player2"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
    else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
    
    //Needs cleaning up, copied code from Rob's Project
}



/*
 
 ======================= 6. END OF GAME METHODS ===========================
 
 */
-(void)blurScene{
//    self.shouldEnableEffects = YES;
//    self.filter = [self blurFilter];
    

    self.scene.shouldEnableEffects = YES;
    self.scene.filter = [self blurFilter];


    //self.scene.blendMode = SKBlendModeMultiply;

    
}
- (CIFilter *)blurFilter
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"]; // 3
    [filter setDefaults];
    [filter setValue:[NSNumber numberWithFloat:10] forKey:@"inputRadius"];
    return filter;
}

-(void)endGame:(int) winningPlayer:(int) p1score:(int) p2score{
      self.view.paused = YES;
      _gameOver = true;
    
    _gameOverScene = [[GameOverScene alloc] initWithSize:CGSizeMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame)) ];
    
    [_gameOverScene setScoresForMenu:player1.getHealth :player2.getHealth];
    
   // SKTransition* transitionDoorsCloseVertical =  [SKTransition doorsCloseHorizontalWithDuration:.6];
    //transitionDoorsCloseVertical.pausesOutgoingScene = false;
    
        doors = [SKTransition doorsOpenHorizontalWithDuration:(2)];
      [self.view presentScene:_gameOverScene transition:doors];
    
    //[self.scene removeAllChildren];
    //self.scene = nil;
    
        //Can we get rid of this below?
//    SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
//    MyScene *newScene = [[MyScene alloc] initWithSize: CGSizeMake(1024,768)];
//    //  Optionally, insert code to configure the new scene.
//    [self.scene.view presentScene: newScene transition: reveal];
    
}
@end
