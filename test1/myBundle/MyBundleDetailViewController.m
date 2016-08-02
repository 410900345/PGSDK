//
//  MyBundleDetailViewController.m
//  JingNi
//
//  Created by yangshuo on 13-12-27.
//  Copyright (c) 2013年 com.pixolity. All rights reserved.
//

#import "MyBundleDetailViewController.h"
#import "Gauge.h"
#import "WordModel.h"



@interface MyBundleDetailViewController ()

@end

@implementation MyBundleDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

+ (NSDictionary*)getMainBundlePathFileWithName:(NSString*)fileName
{
    NSString* docPath = [[NSBundle mainBundle] resourcePath];
    //找到Docutement目录
    NSString* jsonFile = nil;
    if (docPath) {
        jsonFile = [docPath stringByAppendingPathComponent:fileName];
    }
    NSDictionary* dic = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonFile]) {
        //==Json数据
        NSString* jsonString = [NSString stringWithContentsOfFile:jsonFile encoding:NSUTF8StringEncoding error:nil];
        //将字符串写到缓冲区。
        NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        if (!jsonData) {
            return @{};
        }
        //解析json数据，使用系统方法 JSONObjectWithData:  options: error:
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
        if ([dic isKindOfClass:[NSArray class]])
        {
            return dic;
        }
        if (![dic isKindOfClass:[NSDictionary class]])
        {
            dic = [NSDictionary dictionary];
        }
    }
    else
    {
        dic = [NSDictionary dictionary];
    }
    return dic;
}

-(void)saveprogress:(NSString *)str andName:(NSString *)name  {
    NSArray *rootDict = [[self class] getMainBundlePathFileWithName:name];
    NSArray *arryKyword = [str componentsSeparatedByString:@","];
    
    NSMutableDictionary *wordDict = [[NSMutableDictionary alloc] init];
    for (NSString  *word in arryKyword ){
        WordModel *model = [[WordModel alloc] init];
        [wordDict setObject:model forKey:word];
    }
    for (NSArray *dict in rootDict) {
        NSString *str = dict[0];
         NSString *strIndex = [dict[1] stringByReplacingOccurrencesOfString:@"" withString:@"#-0"];
        NSInteger starIndex = [strIndex integerValue];
         NSUInteger strStar = [dict[2] integerValue];
        
        for (NSString *subStr in arryKyword) {
            if ([str containsString:subStr]){
                WordModel *model = wordDict[subStr];
                NSInteger num = [model.wordCount integerValue];
                num ++;
                model.wordCount = @(num);
                if (starIndex <= 10 && strStar >= 4605) {
                    NSInteger numStar = [model.wordStarCount integerValue];
                    numStar ++;
                    model.wordStarCount = @(numStar);
                }
//                [wordDict setObject:[NSNumber numberWithInteger:num] forKey:subStr];
            }
        }
    }
    
//   NSArray *sortArry =  [wordDict keysSortedByValueUsingSelector:@selector(compare:)];
    
     NSArray *myArray = [wordDict keysSortedByValueUsingComparator: ^(WordModel *obj1, WordModel *obj2) {
        
        if ([obj1.wordCount integerValue] > [obj2.wordCount integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        if ([obj1.wordCount integerValue] < [obj2.wordCount integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSMutableArray *numArray = [NSMutableArray array];
     NSMutableArray *numArrayStar = [NSMutableArray array];
    for (NSString *subStr in myArray) {
        
        WordModel *model = wordDict[subStr];
        NSInteger num = [model.wordCount integerValue];
        [numArray addObject:[NSNumber numberWithInteger:num]];
        [numArrayStar addObject:model.wordStarCount];
        //      NSLog(@"-----%@-----%ld ",subStr,num);
    }
//    NSLog(@"-----%@ ",arryKyword);
    NSLog(@"-----%@- ",numArray);
//     NSLog(@"-----%@- ",sortArry);
     NSLog(@"-----%@- ",myArray);
     NSLog(@"-----%@- ",numArrayStar);
}

- (void)testSorts {
    NSDictionary *myDict = @{
                                  @"A" :  [NSNumber numberWithInt:63],
                                  @"B" : [NSNumber numberWithInt:72],
                                  @"C" : [NSNumber numberWithInt:55],
                                  @"D" : [NSNumber numberWithInt:49]};

    NSDictionary *dictionary; // initialize dictionary
    NSArray *sorted = [[dictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[dictionary objectForKey:obj1] compare:[dictionary objectForKey:obj2]];
//        return  [obj1 integerValue] < [obj2 integerValue];
    }];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:63], @"Mathematics",
                          [NSNumber numberWithInt:72], @"English",
                          [NSNumber numberWithInt:55], @"History",
                          [NSNumber numberWithInt:49], @"Geography",
                          nil];
    
    NSArray *sortedKeysArray =
    [myDict keysSortedByValueUsingSelector:@selector(compare:)];
    
    NSArray *myArray;
    
    myArray = [dict keysSortedByValueUsingComparator: ^(id obj1, id obj2) {
        
        if ([obj1 integerValue] > [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    
//    dictionary keysSortedByValueUsingSelector:@selector(compare:)]
    NSLog(@"-----%@,------%@---%@",myArray,sorted,sortedKeysArray);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self creatMyNavgationbar];
//    [self testSorts];
//    return;

    NSString *str = @"每日,雅思,托福,考研,商务,高考,牛津,英孚,儿童,幼儿,懒人,沪江,有道,中英文,英汉,小学,初中,高中,大学,四六级,双语,词典,发音,音标,作业,美剧,大全,留学,达人,题库,词汇,旅行,听书,新东方,扇贝,星火,百度,51,流利说,多说,百词,叽哩呱啦,趣配音,爽哥,学霸,人人,少儿,开心,voa,bbc,ted,出国,在线,日常,基础,语言,教育,阅读,练习,宝典,软件,课堂,词场,学堂";
    [self saveprogress:str andName:@"0802.json"];

    NSString *str1 = @"每日,雅思,托福,考研,商务,高考,牛津,有道,金山,懒人,沪江,留学,儿童,幼儿,小学,初中,高中,大学,中英文,英汉,四六级,双语,词典,词汇,发音,音标,作业,美剧,大全,达人,题库,旅行,听书,新东方,星火,百度,51,流利说,多说,能飞,扇贝,趣配音,百词,叽哩呱啦,爽哥,天天,简单,voa,bbc,ted,出国,学霸,少儿,基础,语言,阅读,练习,宝典,软件,课堂,教育,词场,辞典,学堂";
    
    [self saveprogress:str1 andName:@"0802NCEV.json"];
    
    NSMutableArray *nceArray = [[str componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *nceVArray = [[str1 componentsSeparatedByString:@","] mutableCopy];
    [nceArray removeObjectsInArray:nceVArray];
    
    NSMutableArray *nceArrayTwo = [[str componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *nceVArrayTwo = [[str1 componentsSeparatedByString:@","] mutableCopy];
    [nceVArrayTwo removeObjectsInArray:nceArrayTwo];
    
    NSLog(@"------%@----%@",nceArray,nceVArrayTwo);
//    for (int i = 0; i<3 ; i++)
//    {
//        Gauge *myView = [[Gauge alloc]initWithFrame:CGRectMake(0, i*310+44, 300, 300)];
//        myView.backgroundColor = [UIColor grayColor];
//        [self.view addSubview:myView];
////        myView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    }
}
-(void)creatMyNavgationbar
{
    UIView *navImage = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navImage.backgroundColor = [UIColor colorWithRed:25/255.0 green:97/255.0 blue:175/255.0 alpha:1.0];
    [self.view addSubview:navImage];
    
    //  标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 7, 200, 30)];
    titleLabel.text = @"我的套餐详情";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navImage addSubview:titleLabel];
    //    城市btn
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [closeBtn setImage:[UIImage imageNamed:@"ico_drop.png"] forState:UIControlStateNormal];
    //    [closeBtn setImage:[UIImage imageNamed:@"ico_drop_p.png"] forState:UIControlStateHighlighted];
    closeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [closeBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    closeBtn.frame = CGRectMake(10, 4, 60, 44);
    [navImage addSubview:closeBtn];
}
-(void)closeBtn:(UIButton*)btn
{
    NSLog(@"关闭视图");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
