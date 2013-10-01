//
//  NSArray+Random.m
//  CubeCam
//
//  Created by Jesse Montrose on 9/13/13.
//  Copyright (c) 2013 Jesse Montrose. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

- (id)randomObject
{
    NSUInteger arrayCount = self.count;
    if (!arrayCount) {
        return nil;
    }
    int randomIndex = arc4random_uniform(arrayCount);
    return [self objectAtIndex:randomIndex];
}

@end
