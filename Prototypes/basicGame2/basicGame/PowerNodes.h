//
//  PowerNodes.h
//  basicGame
//
//  Created by Igor Djorganoski on 11/10/2013.
//  Copyright (c) 2013 Robert Siry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface PowerNodes : SKSpriteNode

@property NSString* powerType;
@property float y;
@property CGPoint startingPosition;
@property NSString *powerupIcon;
@property float iconSize;
-(id)init;
//- (id)initPlayer:(int)powerNumber withPosition:(CGPoint)startingPosition withImage:(NSString*)imageName;
-(NSString *)getPowerType;
@end
