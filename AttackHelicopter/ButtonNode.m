//
//  ButtonNode.m
//  Wheel
//
//  Created by edguo on 2014-04-25.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ButtonNode.h"

@implementation ButtonNode

+(instancetype)buttonWithBackground:(SKTexture*)background title:(NSString*)title{
    ButtonNode* node = [ButtonNode spriteNodeWithTexture:background];
    
    node.userInteractionEnabled = YES;
    node.normalEffect = background;
    
    SKLabelNode* labelNode = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Light"];
    
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    [node addChild:labelNode];
    
    node.label = labelNode;
    
    node.label.fontSize = background.size.height/2;
    node.label.text = title;
    node.label.fontColor = [SKColor blackColor];
    
    return node;
}

+(instancetype)buttonWithColor:(SKColor*)color size:(CGSize)size title:(NSString*)title{
    ButtonNode* node = [ButtonNode spriteNodeWithColor:color size:size];
    
    node.userInteractionEnabled = YES;
    
    SKLabelNode* labelNode = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-Light"];
    
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    
    [node addChild:labelNode];
    
    node.label = labelNode;
    
    node.label.fontSize = size.height/2;
    node.label.text = title;
    node.label.fontColor = [SKColor blackColor];
    
    return node;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (!self.trackTouch) {
        self.trackTouch = [touches anyObject];
        if (self.delegate) {
            [self.delegate touchDownOnButton:self];
        }
        if (self.hoverEffect) {
            self.texture = self.hoverEffect;
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.trackTouch) {
        if ([touches containsObject:self.trackTouch]) {
            self.trackTouch = nil;
            if (self.delegate) {
                [self.delegate touchUpOnButton:self];
            }
            if (self.normalEffect) {
                self.texture = self.normalEffect;
            }
        }
    }
}
@end
