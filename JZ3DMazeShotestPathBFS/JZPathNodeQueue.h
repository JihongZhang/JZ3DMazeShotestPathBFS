//
//  JZPathNodeQueue.h
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZPathNode.h"
#include "JZPathNode.h"


@interface JZPathNodeQueue : NSObject

@property (nonatomic) int front;
@property (nonatomic) int real;
 
@property (nonatomic) NSMutableArray *queue;

-(void)pushNodeToQ:(JZPathNode*)node;
-(JZPathNode*)popupNodeFromQ;


-(id)initWithCapacity:(int)capacity;
-(JZPathNode*)getNodeAtIndex:(int)index;

-(BOOL)isQueueEmpty;
-(int)getCount;

@end
