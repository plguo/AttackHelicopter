//
//  ViewController.m
//  AttackHelicopter
//
//  Created by edguo on 2014-04-27.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"
#import "GameScene.h"
#import "MenuScene.h"

@implementation ViewController

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    //skView.showsPhysics = YES;
    // Create and configure the scene.
    if (!skView.scene) {
        SKScene * scene = [[GameScene alloc] initWithSize:skView.bounds.size];
        //SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
        //SKScene * scene = [MenuScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
    
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


@end
