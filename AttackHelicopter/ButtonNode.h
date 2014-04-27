//
//  ButtonNode.h
//  Wheel
//
//  Created by edguo on 2014-04-25.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class ButtonNode;

@protocol ButtonNodeDelegate <NSObject>
-(void)touchDownOnButton:(ButtonNode*)button;
-(void)touchUpOnButton:(ButtonNode*)button;
@end

@interface ButtonNode : SKSpriteNode

+(instancetype)buttonWithBackground:(SKTexture*)background title:(NSString*)title;
+(instancetype)buttonWithColor:(SKColor*)color size:(CGSize)size title:(NSString*)title;

@property(nonatomic, weak) id<ButtonNodeDelegate> delegate;

@property(nonatomic, weak) UITouch* trackTouch;

@property(nonatomic, weak) SKLabelNode* label;

@property(nonatomic) SKTexture* hoverEffect;
@property(nonatomic) SKTexture* normalEffect;

@end
