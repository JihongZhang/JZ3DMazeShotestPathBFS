//
//  JZPathNode.m
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import "JZPathNode.h"

@implementation JZPathNode


-(id)initWithMazePoint:(JZMazePoint*)point direction:(int)direction parent:(int)parent
{
    self = [super init];
    if (self != nil)
    {
        self.point = point;
        self.direction = direction;
        self.parentNode = parent;
    }
    return self;
}

@end
