//
//  PauseButton.m
//  Wheel
//
//  Created by edguo on 2014-04-20.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "PauseButton.h"

@implementation PauseButton{
    BOOL scenePaused;
}
-(id)initPauseButton{
    if (self = [super initWithColor:[SKColor redColor] size:CGSizeMake(40, 40)]) {
        self.userInteractionEnabled = YES;
        scenePaused = NO;
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    scenePaused = !scenePaused;
    if (scenePaused) {
        if (self.delegate) {
            [self.delegate pauseScene];
        }
    }else{
        if (self.delegate) {
            [self.delegate unpauseScene];
        }
    }
}


@end
