//
//  JZPathNode.h
//  JZMazeBot3D
//
//  Created by jihong zhang on 8/30/14.
//  Copyright (c) 2014 JZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JZMazePoint.h"


@interface JZPathNode : NSObject

@property (nonatomic) JZMazePoint *point;
@property (nonatomic) int parentNode;//parent node index in the Q
@property (nonatomic) int direction;


-(id)initWithMazePoint:(JZMazePoint*)point direction:(int)direction parent:(int)parent;

@end
