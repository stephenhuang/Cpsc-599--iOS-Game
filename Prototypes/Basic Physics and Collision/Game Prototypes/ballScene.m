//
//  ballScene.m
//  Game Prototypes
//
//  Created by Stephen  on 2013-10-18.
//  Copyright (c) 2013 Stephen . All rights reserved.
//

#import "ballScene.h"

@implementation ballScene
 static const uint32_t player1 = 0x1 << 0;
 static const uint32_t enemyNodesCategory   = 0x1 << 1;
 static const uint32_t extra   = 0x1 << 2;
 SKLabelNode *label;
 static int count;


-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        // Set gravity to zero
        self.physicsWorld.gravity = CGVectorMake(0,0);
        // look for collisions
        self.physicsWorld.contactDelegate = self;
        count = 0;
        
    }
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

    //Set the Background to white
    self.backgroundColor = [SKColor whiteColor];
    //Fit that shit to screen
    self.scaleMode = SKSceneScaleModeAspectFit;
    //Added border on the screen (nothing can exit out of the frame
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];


    //Create label
    int counter =0;
    label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    label.text = @"00";
    label.fontColor = [SKColor redColor];
    label.fontSize = 30;

    label.position = CGPointMake(CGRectGetMinX(self.frame)+20, CGRectGetMaxY(self.frame)-45);
    [self addChild:label];
    

    
    

    //Creating a ball (which is rectangle right now)
    CGSize ballSize;
    ballSize.width= 100;
    ballSize.height = 100;
    SKSpriteNode *ball = [[SKSpriteNode alloc] initWithColor:[SKColor redColor] size: ballSize];
    //Add it to the bottom of the screen
    ball.position = CGPointMake(CGRectGetMidX(self.frame),
                                CGRectGetMinY(self.frame));
    
    

    //Create a ball on the other side of the screen
    [self addChild:[self createBall]];

    [self addChild:ball];

    
    // -------------- PHYSICS ---------------------------
    
    //Give the ball some physics
    ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
    ball.physicsBody.dynamic = YES;
    //Initial Velocty
    ball.physicsBody.velocity = CGVectorMake(0,1000);
    //Apply a strong force to the object
    //[ball.physicsBody applyImpulse: CGVectorMake(0, 10000)];
    
    
    
    // -------------- COLLISIONS ----------------------
    //Create a rectangle for testing
    SKSpriteNode *smallRect = [[SKSpriteNode alloc] initWithColor:[SKColor greenColor] size: CGSizeMake(10, 10)];
    smallRect.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100);
    [self addChild:smallRect];
    
    
    //Adding the collision groups
    ball.physicsBody.categoryBitMask = player1;
    ball.physicsBody.collisionBitMask = enemyNodesCategory;
    ball.physicsBody.contactTestBitMask = enemyNodesCategory;
    
    smallRect.physicsBody.categoryBitMask = enemyNodesCategory;
    smallRect.physicsBody.collisionBitMask = player1;
    smallRect.physicsBody.contactTestBitMask = player1;
    
    
    //Actions
    SKAction *moveNodeUp = [SKAction moveByX:0.0 y:100.0 duration:1.0];
    SKAction *moveThreeTimes = [SKAction repeatAction:moveNodeUp count:3];
    //[ball runAction: moveNodeUp];
    //[ball runAction: moveThreeTimes];



    
    //Making rocks!
    SKAction *makeRocks = [SKAction sequence: @[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.10 withRange:0.15]
                                                ]];



    
    //[self runAction: [SKAction repeatActionForever:makeRocks]];
}

-(void) updateLabel
{
    count ++;
    NSString *countString = [NSString stringWithFormat:@"%d", count];
    [label setText: countString];

}
static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
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
    
    if ((firstBody.categoryBitMask & player1) !=0)
    {
        [self updateLabel];
    }
    
}

- (void)addRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8,8)];
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}
-(SKShapeNode*)createBall
{
    SKShapeNode *ball2 = [[SKShapeNode alloc] init];
    
    CGMutablePathRef myPath = CGPathCreateMutable();
    CGPathAddArc(myPath, NULL, 0,0, 15, 0, M_PI*2, YES);
    ball2.path = myPath;
    
    ball2.lineWidth = 1.0;
    ball2.fillColor = [SKColor blueColor];
    ball2.strokeColor = [SKColor redColor];
    ball2.glowWidth = 0.5;
    ball2.position = CGPointMake(CGRectGetMidX(self.frame)-200,
                                 CGRectGetMidY(self.frame)-200);
    
    return ball2;
}

@end
