//
//  MapsController.m
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import "MapsController.h"
#import "ENAntiAirCannon.h"
#import "ENFlakGun.h"
#import "ENMissileStation.h"
//static const uint32_t enemyObjectCategory = 0x1 << 3;

@implementation MapsController{
    CGSize screenSize;
    CGFloat WaitCheckPoint;
    CGFloat RemoveCheckPoint;
}

-(id)initControllerWithScreenSize:(CGSize)size TileMap:(TileMap*)tileM WorldMap:(SKNode*)worldM Player:(Helicopter*)player{
    if (self = [super init]) {
        screenSize = size;
        self.minPerloadRange = size.width * 1.0;
        self.minRemoveRange = size.width * 0.4;
        
        self.player = player;
        self.tileMap = tileM;
        self.worldMap = worldM;
        
        self.expanable = YES;
        self.removeable = YES;
        self.nextEnemyIndex = 0;
        
        WaitCheckPoint = -1.0;
        RemoveCheckPoint = -1.0;
        
        self.enemyRemoveArray = [NSPointerArray weakObjectsPointerArray];
        self.enemyWaitArray = [NSPointerArray weakObjectsPointerArray];
        
        [self checkLoadTile];
        [self loadEnemyFile];
    }
    return self;
}

-(void)loadEnemyFile{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"TestRange" ofType:@"enemy"];
    NSString* fileData = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSArray *lineArray = [fileData componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    if (!lineArray || [lineArray count] < 1) return;
    
    NSMutableArray *processedArray = [NSMutableArray arrayWithCapacity:[lineArray count]];
    
    for (NSUInteger i = 0; i < [lineArray count]; i++) {
        NSString* string = [lineArray objectAtIndex:i];
        NSArray* stringArray = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        NSString* subString = [stringArray objectAtIndex:0];
        
        NSNumber* column = [NSNumber numberWithUnsignedInteger:[subString integerValue]];
        [processedArray setObject:@[column,[stringArray objectAtIndex:1]] atIndexedSubscript:i];
    }
    
    self.enemyRawArray = processedArray;
    self.moreEnemy = YES;
    self.nextEnemyIndex = 0;
    NSNumber* number = [[self.enemyRawArray objectAtIndex:0] objectAtIndex:0];
    self.nextEnemyColumn = [number unsignedIntegerValue];
}



-(void)checkLoadTile{
    if (self.tileMap) {
        if (self.removeable) {
            CGFloat dis = self.player.position.x -self.minRemoveRange;
            if (self.tileMap.loadStartX < dis) {
                dis += 30;
                if (self.tileMap.loadEndX - dis > screenSize.width || self.expanable) {
                    [self.tileMap removeTilesToX:dis];
                }else{
                    self.removeable = NO;
                }
                
            }
        }
        if (self.expanable) {
            //Check if require to load more tile
            if (self.tileMap.loadEndX < self.player.position.x +self.minPerloadRange) {
                BOOL isPossibleToExpand = [self.tileMap expandTilesToX:self.player.position.x +self.minPerloadRange + 30.0];
                if (!isPossibleToExpand) {
                    self.expanable = NO;
                }
            }
        }
    }
}

-(ENSprite*)newEnemyWithType:(NSString*)name{
    if ([name isEqualToString:@"A"]) {
        return [[ENAntiAirCannon alloc] initEnemySprite];
    }else if ([name isEqualToString:@"B"]){
        return [[ENFlakGun alloc] initEnemySprite];
    }else if ([name isEqualToString:@"C"]){
        return [[ENMissileStation alloc] initEnemySprite];
    }
    return nil;
}

-(void)checkLoadEnemy{
    if (self.moreEnemy) {
        if (self.tileMap.loadEndIndex > self.nextEnemyColumn) {
            NSArray* emenyInfo = [self.enemyRawArray objectAtIndex:self.nextEnemyIndex];
            NSString* name = [emenyInfo objectAtIndex:1];
            
            ENSprite*sprite = [self newEnemyWithType:name];
            if (sprite) {
                NSNumber* heightNumber = [self.tileMap.rawArray objectAtIndex:self.nextEnemyColumn];
                NSUInteger height = [heightNumber unsignedIntegerValue];
                CGFloat posX,posY;
                posX = TILE_WIDTH * (self.nextEnemyColumn + 0.5);
                posY = TILE_WIDTH * (height + 0.5) + sprite.size.height/2;
                
                sprite.position = CGPointMake(posX, posY);
                if (WaitCheckPoint < 0) {
                    WaitCheckPoint = sprite.position.x - screenSize.width;
                }else{
                    WaitCheckPoint = MIN(WaitCheckPoint, sprite.position.x - screenSize.width);
                }
                [self.enemyWaitArray addPointer:(void *)sprite];
                
                [self.worldMap addChild:sprite];
                self.nextEnemyIndex++;
                if (self.nextEnemyIndex < [self.enemyRawArray count]) {
                    NSNumber* number = [[self.enemyRawArray objectAtIndex:self.nextEnemyIndex] objectAtIndex:0];
                    self.nextEnemyColumn = [number unsignedIntegerValue];
                }else{
                    self.moreEnemy = NO;
                }
            }
            
        }
    }
}

-(void)checkEnemyAction{
    if (WaitCheckPoint >= 0) {
        if (WaitCheckPoint < self.player.position.x) {
            WaitCheckPoint = - 1.0;
            [self.enemyWaitArray compact];
            for (NSUInteger i =0; i<[self.enemyWaitArray count];i++ ) {
                ENSprite* sprite = (ENSprite*)[self.enemyWaitArray pointerAtIndex:i];
                if (sprite) {
                    if (sprite.position.x - self.player.position.x <screenSize.width) {
                        sprite.targetNode = self.player;
                        [sprite startAction];
                        [self.enemyWaitArray removePointerAtIndex:i];
                        i --;
                        
                        [self.enemyRemoveArray addPointer:(void *)sprite];
                        if (RemoveCheckPoint < 0) {
                            RemoveCheckPoint = sprite.position.x + self.minRemoveRange;
                        }else{
                            RemoveCheckPoint = MIN(RemoveCheckPoint, sprite.position.x + self.minRemoveRange);
                        }
                    } else {
                        if (WaitCheckPoint < 0) {
                            WaitCheckPoint = sprite.position.x - screenSize.width;
                        }else{
                            WaitCheckPoint = MIN(WaitCheckPoint, sprite.position.x - screenSize.width);
                        }
                    }
                }else{
                    [self.enemyWaitArray removePointerAtIndex:i];
                    i --;
                }
            }
        }
    }
    
    if (RemoveCheckPoint >= 0) {
        if (RemoveCheckPoint < self.player.position.x) {
            RemoveCheckPoint = - 1.0;
            [self.enemyRemoveArray compact];
            for (NSUInteger i =0; i<[self.enemyRemoveArray count];i++ ) {
                ENSprite* sprite = (ENSprite*)[self.enemyRemoveArray pointerAtIndex:i];
                if (sprite) {
                    if (sprite.position.x - self.player.position.x < -self.minRemoveRange) {
                        if (self.removeable) {
                            [sprite removeFromParent];
                        }
                        [self.enemyRemoveArray removePointerAtIndex:i];
                        i --;
                    } else {
                        if (RemoveCheckPoint < 0) {
                            RemoveCheckPoint = sprite.position.x + self.minRemoveRange;
                        }else{
                            RemoveCheckPoint = MIN(RemoveCheckPoint, sprite.position.x + self.minRemoveRange);
                        }
                    }
                }else{
                    [self.enemyRemoveArray removePointerAtIndex:i];
                    i --;
                }
            }
        }
    }
    
    
}

-(void)moveMapWithInterval:(NSTimeInterval)time{
    //New X = Current position + change in x
    CGFloat newX = self.player.position.x - 100;
    
    //Limit the Lower bound
    if (self.player.velocity.dx >= 0 || newX > self.tileMap.loadStartX+10) {
        self.player.position = CGPointMake(self.player.position.x + self.player.velocity.dx*time, self.player.position.y + self.player.velocity.dy*time);
        
        // Maximum Distance = The distance has already loaded - Screen width - Helicopter Position(Defult 100.0)
        CGFloat max_X = self.tileMap.loadEndX - screenSize.width;// - 100;
        
        self.worldMap.position = CGPointMake(-MIN(max_X, self.player.position.x - 100), 0);
        
        [self checkLoadTile];
        [self checkLoadEnemy];
        [self checkEnemyAction];
        
    }
    
}
@end
