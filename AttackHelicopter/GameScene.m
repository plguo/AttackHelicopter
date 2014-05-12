//
//  GameScene.m
//  Wheel
//
//  Created by edguo on 2014-04-12.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "GameScene.h"
#import "OverScene.h"

@implementation GameScene{
    CGVector heliVector;
    BOOL playerShooting;
    
    NSTimeInterval lastUpdateTime;
}
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0 green:0.69 blue:1.0 alpha:0.0];
        
        SKSpriteNode* cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"clouds_tk"];
        cloud1.position = CGPointMake(200, 200);
        [self addChild:cloud1];
        
        SKSpriteNode* cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"clouds_tk"];
        cloud2.position = CGPointMake(300, 250);
        [self addChild:cloud2];
        
        SKSpriteNode* cloud3 = [SKSpriteNode spriteNodeWithImageNamed:@"clouds_tk"];
        cloud3.position = CGPointMake(440, 225);
        [self addChild:cloud3];
        
        
        SKNode* world = [SKNode node];
        world.zPosition = 1.0;
        [self addChild:world];
        self.gameWorld = world;
        
        TileMap* map = [[TileMap alloc]initMapWithScreenSize:self.size File:@"TestRange"];
        [self.gameWorld addChild:map];
        self.tileMap = map;
        
        Helicopter* mainHelicopter = [[Helicopter alloc] initHelicopter];
        mainHelicopter.position = CGPointMake(100, 240);
        [self.gameWorld addChild:mainHelicopter];
        self.mainHelicopter = mainHelicopter;
        self.mainHelicopter.delegate = self;
        
        SKNode* uiLayer = [SKNode node];
        uiLayer.zPosition = 10.0;
        [self addChild:uiLayer];
        self.interfaceLayer = uiLayer;
        
        //Setup Buttons
        Joystick* joystick1 = [[Joystick alloc]initJoystick];
        joystick1.position = CGPointMake(34, 34);
        joystick1.delegate = self;
        joystick1.zPosition = 1.0;
        joystick1.joystickScale = 7.0;
        [self.interfaceLayer addChild:joystick1];
        
        RocketButton* rButton = [[RocketButton alloc] initButton];
        rButton.position = CGPointMake(self.size.width - 40.0, 40.0);
        rButton.delegate = self.mainHelicopter;
        rButton.zPosition = 1.0;
        [self.interfaceLayer addChild:rButton];
        
        ShootButton* sButton = [[ShootButton alloc]initShootButton];
        sButton.position = CGPointMake(self.size.width - 100.0, 40.0);
        sButton.delegate = self.mainHelicopter;
        sButton.zPosition = 1.0;
        [self.interfaceLayer addChild:sButton];
        
        PauseButton* pButton = [[PauseButton alloc]initPauseButton];
        pButton.position = CGPointMake(30, self.size.height - 30);
        pButton.delegate = self;
        pButton.zPosition = 1.0;
        [self.interfaceLayer addChild:pButton];
        
        HealthDisplayer* hdisplayer = [[HealthDisplayer alloc]initDisplayer];
        hdisplayer.position = CGPointMake(100, self.size.height - 20.0);
        hdisplayer.zPosition = 1.0;
        [self.interfaceLayer addChild:hdisplayer];
        self.mainHelicopter.healthDelegate = hdisplayer;
        
        AmmoDisplayer* adisplayer = [[AmmoDisplayer alloc]initDisplayerWithCannon:self.mainHelicopter.cannon];
        adisplayer.position = CGPointMake(200, self.size.height - 12.0);
        adisplayer.zPosition = 1.0;
        [self.interfaceLayer addChild:adisplayer];
        
        SKLabelNode* markLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
        markLabel.text = @"0";
        markLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        markLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        markLabel.position = CGPointMake(self.size.width - 12.0, self.size.height - 24.0);
        markLabel.zPosition = 1.0;
        [self.interfaceLayer addChild:markLabel];
        self.markLabel = markLabel;
        
        self.MController = [[MapsController alloc]initControllerWithScreenSize:self.size
                                                                       TileMap:self.tileMap
                                                                      WorldMap:self.gameWorld
                                                                        Player:self.mainHelicopter];
        
        self.physicsWorld.contactDelegate = self;        
        
    }
    return self;
}


-(void)update:(NSTimeInterval)currentTime{
    if (!self.paused) {
        [self updateMapControllerWithTimeInterval:currentTime-lastUpdateTime];
        lastUpdateTime = currentTime;
    }
}

-(void)updateMapControllerWithTimeInterval:(NSTimeInterval)time{
    [self.MController moveMapWithInterval:time];
    
    if (self.mainHelicopter.velocity.dx != 0) {
        if (self.scope) {
            if (!self.scope.parent) {
                self.scope = nil;
            }else{
                [self.scope updatePosition];
            }
        }
    }
}


-(void)joystickVectorChange:(CGVector)vector{
    self.mainHelicopter.velocity = vector;
    self.mainHelicopter.zRotation = -self.mainHelicopter.velocity.dx*0.01;
}

-(void)joystickEnd{
    self.mainHelicopter.velocity = CGVectorMake(0, 0);
    [self.mainHelicopter runAction:[SKAction rotateToAngle:0 duration:0.5 shortestUnitArc:YES] completion:^{
        if (self.scope) {
            if (!self.scope.parent) {
                self.scope = nil;
            }else{
                [self.scope updatePosition];
            }
        }
    }];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    for(UITouch* touch in touches){
        NSArray* nodes = [self nodesAtPoint:[touch locationInNode:self]];
        for (SKNode* node in nodes) {
            if ([node isKindOfClass:[ENSprite class]]) {
                if (self.scope) {
                    if (!self.scope.parent) {
                        self.scope = nil;
                    }else{
                        [self.scope targetNewSprite:(ENSprite*)node];
                    }
                }
                
                if (!self.scope) {
                    TargetScope* scope = [[TargetScope alloc]initTargetScopeWithEnsprite:(ENSprite*)node];
                    scope.alpha = 0.0;
                    [self.interfaceLayer addChild:scope];
                    scope.delegate = self.mainHelicopter;
                    self.scope = scope;
                    scope.alpha = 1.0;
                }
                break;
                
            }
        }
        
        
    }
    
}

-(void)helicopterKilled{
    [self persentGameOverScene];
}

-(void)persentGameOverScene{
    OverScene* gameOverScene = [[OverScene alloc]initWithSize:self.size];
    [self.view presentScene:gameOverScene transition:[SKTransition flipHorizontalWithDuration:0.5]];
}

-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody* bodyA;
    SKPhysicsBody* bodyB;
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        bodyA = contact.bodyA;
        bodyB = contact.bodyB;
    }else{
        bodyA = contact.bodyB;
        bodyB = contact.bodyA;
    }
    
    if (bodyA.categoryBitMask == CategoryTile && (bodyB.categoryBitMask == CategoryFriendWeapon || bodyB.categoryBitMask == CategoryEnemyWeapon)) {
        //When Tile collide with any weapon
        
        Tile* tile = (Tile*)bodyA.node;
        Weapon* friendWeapon = (Weapon*)bodyB.node;
        if ([tile loseHealth:friendWeapon.damage]) {
            [self.tileMap destoryTile:tile];
        }
        [friendWeapon explodeEffect];
        [bodyB.node removeFromParent];
    } else if (bodyA.categoryBitMask == CategoryTile && bodyB.categoryBitMask == CategoryHelicopter){
        //When Tile collide with helicopter
        
        [self persentGameOverScene];
    } else if (bodyA.categoryBitMask == CategoryFriendWeapon && bodyB.categoryBitMask == CategoryEnemyObject){
        //When friendly weapon collide with enemy
        
        Weapon* weaponA = (Weapon*)bodyA.node;
        ENSprite* spriteB = (ENSprite*)bodyB.node;
        
        if ([spriteB isKillInDamage:weaponA.damage]) {
            [spriteB removeFromParent];
            self.playerMark += (NSUInteger)spriteB.reward;
            self.markLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.playerMark];
        }
        [weaponA removeFromParent];
    } else if (bodyA.categoryBitMask == CategoryHelicopter && bodyB.categoryBitMask == CategoryEnemyWeapon){
        Helicopter* heli = (Helicopter*)bodyA.node;
        Weapon* weapon =(Weapon*)bodyB.node;
        [heli damage:weapon.damage];
        [weapon explodeEffect];
        [bodyB.node removeFromParent];
    } else if (bodyA.categoryBitMask == CategoryEnemyWeapon && bodyB.categoryBitMask == CategoryFriendWeapon){
        Weapon *weaponA = (Weapon*)bodyA.node;
        Weapon *weaponB = (Weapon*)bodyB.node;
        
        if ([weaponB isKillInDamage:weaponA.damage]) {
            [weaponB removeFromParent];
        }
        
        if ([weaponA isKillInDamage:weaponB.damage]) {
            [weaponA removeFromParent];
        }
        
    }
}

-(void)pauseScene{
    self.paused = YES;
}

-(void)unpauseScene{
    self.paused = NO;
}

@end

