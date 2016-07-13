//
//  CustomClass.m
//  test1
//
//  Created by yangshuo on 14-12-25.
//  Copyright (c) 2014年 yangshuo. All rights reserved.
//

#import "CustomClass.h"

@implementation ClassCustomClass

@synthesize varTest1, varTest2, varTest3;

- (void) fun1
{
    NSLog(@"fun1");
}

@end


@implementation ClassCustomClassOther
- (void) fun2
{
    NSLog(@"fun2");
}
@end

@implementation ClassMethodViewCtr

- (void) justLog1 {
    NSLog(@"justLog1");
}
- (void) justLog2 {
    NSLog(@"justLog2");
}
@end