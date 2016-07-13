//
//  CustomViewController.m
//  test1
//
//  Created by yangshuo on 14-12-25.
//  Copyright (c) 2014年 yangshuo. All rights reserved.
//

#import "CustomViewController.h"

#import "CustomClass.h"
#import <objc/runtime.h>
#import <MediaPlayer/MediaPlayer.h>
@interface TestClass : NSObject
@end

@implementation TestClass

@end



@interface CustomViewController ()
{
    MPMoviePlayerController *m_moviePlayer;
}
@end

@implementation CustomViewController
{
      float myFloat;
      ClassCustomClass *allobj;
    
    IMP cFuncPointer;
    IMP cFuncPointer1;
    IMP cFuncPointer2;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.view.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myFloat = 2.34f;
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"]];
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSRange raneOne = [str rangeOfString:@"{"];
//        NSRange raneTwo = [str rangeOfString:@"}"];
//        @"{1234}";
//        NSString *subString = [str  substringWithRange:NSMakeRange(raneOne.location, raneTwo.location-raneOne.location+1)];
//        NSLog(@"%@",subString);
//    });
    // Do any additional setup after loading the view.
//    [self testRuntime];
    
//    NSString *mp4UrlStr = [[NSBundle mainBundle] pathForResource:@"ybvam1" ofType:@"Mp4"];;
//    if (mp4UrlStr.length)
//    {
//        m_moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:mp4UrlStr]];
//        //        m_moviePlayer.allowsAirPlay = YES;
//        [m_moviePlayer.view setFrame:CGRectMake(0, 100, 350/2.0, 111)];
//        m_moviePlayer.scalingMode = MPMovieScalingModeAspectFit;     //适应屏幕大小，保持宽高比
//        m_moviePlayer.controlStyle = MPMovieControlStyleNone;
//        [self.view addSubview:m_moviePlayer.view];
//    }

//    @"苡诽冉佌帨觑锉诿供枀8话怷闾颈9;
    NSString *str =  @"Ft皃吃秊甯逓";
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0;i < str.length; i++)
    {
        NSString *str1 = [str substringWithRange:NSMakeRange(i, 1)];
        [array addObject:str1];
    }
    
    [self getDecodeStr:str];
//      mychar[i] = (char) (mychar[i] ^ (str.length));
    
//     NSString *str =  @"es1_1";
    
//     const char *c = [str cStringUsingEncoding:NSUTF8StringEncoding];
//     NSString *str1 = [[NSString alloc] initWithCString:c encoding:NSUTF8StringEncoding];
//    [self getDecodeStr:str];
    
//    NSString *srr =  [self hexStringFromData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
//    NSString *strONE = @"Hello There";
//    const char *c = [str cStringUsingEncoding:NSUTF8StringEncoding];
//   for (int i = 0; i <strlen(c); i++)
//    {
//        NSLog(@"---%c",c[i]);
}
// `v4Z4 es1_1
- (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [utf8string dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}

-(NSString *)getDecodeStr:(NSString *)str
{
    NSStringEncoding encoding = NSUTF8StringEncoding;
//    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *strB = [@"中国"stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *test= str;
    NSUInteger bytes = [test lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%i bytes", bytes);
    
    NSString * mystring = @"";
    char mychar[1000];
    const char *c = [str cStringUsingEncoding:encoding];
    strcpy(mychar,c);
    int length = strlen(c);
    
    for (int i = 0; i < length; i++)
    {
        if (2 == i%3)
        {
             mychar[i] =  mychar[i]^7;
        }
    }
//   mystring=[NSString stringWithFormat:@"%s",mychar];
    mystring=[NSString stringWithCString:mychar encoding:encoding];
    NSLog(@"------%@",mystring);
     NSLog(@"------%@",[self UTF8_To_GB2312:mystring]);
    return mystring;
}


- (NSString *)hexStringFromData:(NSData *)data
{
    NSMutableString *str = [NSMutableString string];
    Byte *byte = (Byte *)[data bytes];
    for (int i = 0; i<[data length]; i++) {
        // byte+i为指针
        [str appendString:[self stringFromByte:*(byte+i)]];
    }
    return str;
}


- (NSString *)stringFromByte:(Byte)byteVal
{
    NSMutableString *str = [NSMutableString string];
    //取高四位
//    Byte byte1 = byteVal>>4;
    //取低四位
//    Byte byte2 = byteVal & 0xf;
    //拼接16进制字符串
    [str appendFormat:@"%c",byteVal^7];
//    [str appendFormat:@"%x",byte2];
    return str;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [m_moviePlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark shixian
-(void)testRuntime
{
//    [self copyObject];
//    
//    [self oneParam];
//    
//    [self twoParam];
//    
//    [self setClassTest];
    
//    [self getClassAllMethod];
//    [self propertyNameList];
    
//    [self getInstanceVar];
//    [self setInstanceVar];
//    [self getVarType];
//    [self nameOfInstance:<#(id)#>];
//    allobj = [ClassCustomClass new];
//    allobj.varTest1 =@"varTest1String";
//    allobj.varTest2 =@"varTest2String";
//    allobj.varTest3 =@"varTest3String";
//    NSString *str = [self nameOfInstance:@"varTest1String"];
//    NSLog(@"str:%@", str);

//    [self methodExchange];
//    
//   ClassMethodViewCtr * allobj1 = [ClassMethodViewCtr new];
//    [self methodSetImplementation];
//    [allobj1 justLog2];
    [self replaceMethod];
}


- (void) propertyNameList
{
    u_int count;
    objc_property_t *properties=class_copyPropertyList([UIViewController class], &count);
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        NSString *strName = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }
}

- (void) getClassAllMethod
{
    u_int count;
    Method* methods= class_copyMethodList([UIViewController class], &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name)encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }
}

//对象拷贝
//-(void)copyObject
//{
//    CustomClass *obj = [CustomClass new];
//    NSLog(@"%p",&obj);
//    
//    id testObject = object_copy(obj, sizeof(obj));
//     NSLog(@"%p",&testObject);
//    
//    NSString *className = [NSString stringWithCString:object_getClassName(obj)encoding:NSUTF8StringEncoding];
//    NSLog(@"className:%@", className);
//}

int cfunction(id self, SEL _cmd, NSString *str) {
    NSLog(@"%@", str);
    return 10;//随便返回个值
}

int cfunctionA(id self, SEL _cmd, NSString *str, NSString *str1) {
    NSLog(@"%@-%@", str, str1);
    return 20;//随便返回个值
}

- (void)oneParam {
    TestClass *instance = [[TestClass alloc]init];
    //    方法添加
    class_addMethod([TestClass class],@selector(ocMethod:), (IMP)cfunction,"i@:@");
    
    if ([instance respondsToSelector:@selector(ocMethod:)]) {
        NSLog(@"Yes, instance respondsToSelector:@selector(ocMethod:)");
    } else
    {
        NSLog(@"Sorry");
    }
    
    int a = (int)[instance ocMethod:@"我是一个OC的method，C函数实现"];
    NSLog(@"a:%d", a);
}

- (void) twoParam {
    
    TestClass *instance = [[TestClass alloc]init];
    
    class_addMethod([TestClass class],@selector(ocMethodA::), (IMP)cfunctionA,"i@:@@");
    
    if ([instance respondsToSelector:@selector(ocMethodA::)]) {
        NSLog(@"Yes, instance respondsToSelector:@selector(ocMethodA::)");
    } else
    {
        NSLog(@"Sorry");
    }
    
    int a = (int)[instance ocMethodA:@"我是一个OC的method，C函数实现" :@"-----我是第二个参数"];
    NSLog(@"a:%d", a);
}



//- (void) setClassTest
//{
//    CustomClass *obj = [CustomClass new];
//    [obj fun1];
//    
//    Class aClass =object_setClass(obj, [ClassCustomClassOther class]);
//    //obj 对象的类被更改了    swap the isa to an isa
//    NSLog(@"aClass:%@",NSStringFromClass(aClass));
//    NSLog(@"obj class:%@",NSStringFromClass([obj class]));
////    [obj fun2];
//}
//- (void) getClassTest
//{
//    CustomClass *obj = [CustomClass new];
//    Class aLogClass =object_getClass(obj);
//    NSLog(@"%@",NSStringFromClass(aLogClass));
//}

//获取全局变量的值   （myFloat 为类的一个属性变量）
- (void) getInstanceVar
{
    float myFloatValue;
    object_getInstanceVariable(self,"myFloat", (void*)&myFloatValue);
    NSLog(@"%f", myFloatValue);
}

//设置全局变量的值
- (void) setInstanceVar {
    float newValue = 10.00f;
    unsigned int addr = (unsigned int)&newValue;
    object_setInstanceVariable(self,"myFloat", *(float**)addr);
    NSLog(@"%f", myFloat);
}



- (void) getVarType {
    ClassCustomClass *obj = [ClassCustomClass new];
    Ivar var = class_getInstanceVariable(object_getClass(obj),"varTest1");
    const char* typeEncoding =ivar_getTypeEncoding(var);
    NSString *stringType =  [NSString stringWithCString:typeEncoding encoding:NSUTF8StringEncoding];
    
    if ([stringType hasPrefix:@"@"]) {
        // handle class case
        NSLog(@"handle class case");
    } else if ([stringType hasPrefix:@"i"]) {
        // handle int case
        NSLog(@"handle int case");
    } else if ([stringType hasPrefix:@"f"]) {
        // handle float case
        NSLog(@"handle float case");
    } else
    {
        
    }
}


- (NSString *)nameOfInstance:(id)instance
{
    unsigned int numIvars =0;
    NSString *key=nil;
    
    //Describes the instance variables declared by a class.
    Ivar * ivars = class_copyIvarList([ClassCustomClass class], &numIvars);
    
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = ivars[i];
        
        const char *type =ivar_getTypeEncoding(thisIvar);
        NSString *stringType =  [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
        
        //不是class就跳过
        if (![stringType hasPrefix:@"@"]) {
            continue;
        }
        
        //Reads the value of an instance variable in an object. object_getIvar这个方法中，当遇到非objective-c对象时，并直接crash
        if ((object_getIvar(allobj, thisIvar) == instance)) {
            // Returns the name of an instance variable.
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
            break;
        }
    }
    free(ivars);
    return key;
}

- (void) methodExchange {
    Method m1 = class_getInstanceMethod([NSString class],@selector(lowercaseString));
    Method m2 = class_getInstanceMethod([NSString class],@selector(uppercaseString));
    method_exchangeImplementations(m1, m2);
    NSLog(@"%@", [@"sssAAAAss"lowercaseString]);
    NSLog(@"%@", [@"sssAAAAss"uppercaseString]);
}

- (void) methodSetImplementation {
    Method method = class_getInstanceMethod([ClassMethodViewCtr class],@selector(justLog1));
    IMP originalImp = method_getImplementation(method);
    Method m1 = class_getInstanceMethod([ClassMethodViewCtr class],@selector(justLog2));
    method_setImplementation(m1, originalImp);

}


//NSString* CustomUppercaseString(id self,SEL _cmd){
//    printf("真正起作用的是本函数CustomUppercaseString\r\n");
//    NSString *string = cFuncPointer(self,_cmd);
//    return string;
//}
//NSArray* CustomComponentsSeparatedByString(id self,SEL _cmd,NSString *str){
//    printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//    return cFuncPointer1(self,_cmd, str);
//}
////不起作用，求解释
//bool CustomIsEqualToString(id self,SEL _cmd,NSString *str)
//{
//    printf("真正起作用的是本函数CustomIsEqualToString\r\n");
//    return cFuncPointer2(self,_cmd, str);
//}
//- (void) replaceMethod{
//    
//    cFuncPointer = [NSString instanceMethodForSelector:@selector(uppercaseString)];
//    class_replaceMethod([NSString class],@selector(uppercaseString), (IMP)CustomUppercaseString,"@@:");
//    cFuncPointer1 = [NSString instanceMethodForSelector:@selector(componentsSeparatedByString:)];
//    class_replaceMethod([NSString class],@selector(componentsSeparatedByString:), (IMP)CustomComponentsSeparatedByString,"@@:@");
//    cFuncPointer2 = [NSString instanceMethodForSelector:@selector(isEqualToString:)];
//    class_replaceMethod([NSString class],@selector(isEqualToString:), (IMP)CustomIsEqualToString,"B@:@");
//}


@end
