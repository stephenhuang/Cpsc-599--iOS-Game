//
//  MyScene.m
//  basicGame
//
//  Created by Robert Siry on 2013-10-25.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import "MyScene.h"

static NSString * const kAnimalNodeName = @"movable";
@interface MyScene ()

@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        // 1) Loading the background
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"backGround.jpg"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        [self addChild:_background];
        
        // 2) Loading the images
        NSArray *imageNames = @[@"Untitled.png", @"player2.png"];
        for(int i = 0; i < [imageNames count]; ++i) {
            NSString *imageName = [imageNames objectAtIndex:i];
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
            [sprite setName:kAnimalNodeName];
            
            float offsetFraction = ((float)(i + 1)) / ([imageNames count] + 8);
            [sprite setPosition:CGPointMake(size.width * offsetFraction, size.height / 2)];
            [_background addChild:sprite];
        }
    }
    return self;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    //2
	if(![_selectedNode isEqual:touchedNode]) {
		[_selectedNode removeAllActions];
		[_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		_selectedNode = touchedNode;
		//3
		if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-8.0f) duration:0.1],
													  [SKAction rotateByAngle:0.0 duration:0.1],
													  [SKAction rotateByAngle:degToRad(8.0f) duration:0.1]]];
			[_selectedNode runAction:[SKAction repeatActionForever:sequence]];
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
    if([[_selectedNode name] isEqualToString:kAnimalNodeName]) {
        [_selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
}


@end
