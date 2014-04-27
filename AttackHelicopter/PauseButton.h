//
//  PauseButton.h
//  Wheel
//
//  Created by edguo on 2014-04-20.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class PauseButton;
@protocol PauseButtonDelegate <NSObject>
-(void)pauseScene;
-(void)unpauseScene;
@end

@interface PauseButton : SKSpriteNode
-(id)initPauseButton;
@property(nonatomic, weak) id<PauseButtonDelegate> delegate;
@end
