//
//  MapsController.h
//  Wheel
//
//  Created by edguo on 2014-04-17.
//  Copyright (c) 2014 Edward Peiliang Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileMap.h"
#import "Helicopter.h"

@interface MapsController : NSObject

-(id)initControllerWithScreenSize:(CGSize)size TileMap:(TileMap*)tileM WorldMap:(SKNode*)worldM Player:(Helicopter*)player;
-(void)moveMapWithInterval:(NSTimeInterval)time;

@property(nonatomic, weak) SKNode* worldMap;
@property(nonatomic, weak) TileMap* tileMap;
@property(nonatomic, weak) Helicopter* player;

@property(nonatomic) NSMutableArray* enemyRawArray;

@property(nonatomic) NSPointerArray* enemyWaitArray;
@property(nonatomic) NSPointerArray* enemyRemoveArray;

@property(nonatomic) BOOL expanable;
@property(nonatomic) BOOL removeable;

@property(nonatomic) BOOL moreEnemy;
@property(nonatomic) NSUInteger nextEnemyIndex;
@property(nonatomic) NSUInteger nextEnemyColumn;

@property(nonatomic) CGFloat minPerloadRange;
@property(nonatomic) CGFloat minRemoveRange;

@end
