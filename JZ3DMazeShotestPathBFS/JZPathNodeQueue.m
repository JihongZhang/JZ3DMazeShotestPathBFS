//
//  JZPathNodeQueue.m
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZPathNodeQueue.h"
#import "JZPathNode.h"


@implementation JZPathNodeQueue

-(id)initWithCapacity:(int)capacity
{
    self = [super init];
    if (self != nil)
    {
        self.front = 0;
        self.real = 0;
        self.queue = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}

-(void)pushNodeToQ:(JZPathNode*)node
{
    [self.queue addObject:node];
    self.real++;
}

-(JZPathNode*)popupNodeFromQ
{
    if(self.front != self.real){
        JZPathNode *node = [self.queue objectAtIndex: self.front];
        self.front++;
        return node;
    }
    return Nil;
}

-(JZPathNode*)getNodeAtIndex:(int)index
{
    if(index < self.real && index >= 0){
        return [self.queue objectAtIndex: index];
    }
    return Nil;
}

-(BOOL)isQueueEmpty
{
    if(self.front == self.real)
        return YES;
    else
        return NO;
}

-(int)getCount
{
    return self.real;
}

@end
