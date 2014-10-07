//
//  JZMazePoint.m
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZMazePoint.h"

@implementation JZMazePoint

-(id)initWithx:(int)x y:(int)y layer:(int)layer
{
    self = [super init];
    if (self != nil)
    {
        self.x = x;
        self.y = y;
        self.layer = layer;
    }
    return self;
}

-(BOOL)isSameAs:(JZMazePoint*)p
{
    if((self.x == p.x) && (self.y == p.y) && (self.layer == p.layer))
        return YES;
    else
        return NO;
}

@end
