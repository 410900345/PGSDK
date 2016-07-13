//
//  CustomClass.h
//  test1
//
//  Created by yangshuo on 14-12-25.
//  Copyright (c) 2014年 yangshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassCustomClass : NSObject


@property (nonatomic,assign)NSString *varTest1;
@property (nonatomic,assign)NSString *varTest2;
@property (nonatomic,assign)NSString *varTest3;

- (void) fun1;

@end




@interface ClassCustomClassOther :NSObject {
    int varTest2;
}
- (void) fun2;

@end

@interface ClassMethodViewCtr :NSObject

-(void)justLog1;
-(void)justLog2;
@end
