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

#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry.h"

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
                if (strStar >= 4605) {
                     num ++;
                     model.wordCount = @(num);
                }
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
     NSLog(@"所有关键词-----%@- ",myArray);
     NSLog(@"有效关键词覆盖数-----%@- ",numArray);
     NSLog(@"前10关键词-----%@- ",numArrayStar);
    
    
    UIView *greenView1 = UIView.new;
    greenView1.backgroundColor = UIColor.greenColor;
    greenView1.layer.borderColor = UIColor.blackColor.CGColor;
    greenView1.layer.borderWidth = 2;
    [self.view addSubview:greenView1];
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [greenView1 addSubview:greenView];
    
     int padding = 10;
    
    [greenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(self.view.left).offset(padding);
        make.bottom.equalTo(self.view.top).offset(-padding);
        make.right.equalTo(self.view.left).offset(-padding);
        make.width.equalTo(self.view.width);
        
        make.height.equalTo(self.view.height);
        make.height.equalTo(self.view.height);
        
    }];
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


- (NSArray *)nceEnglish {
    
    NSString *str = @"每日,雅思,托福,考研,商务,高考,牛津,儿童,幼儿,懒人,沪江,有道,中英文,英汉,小学,初中,高中,大学,四六级,美剧,发音,音标,留学,题库,词典,旅行,听书,作业,攻略,视频,直播,大全,达人,新东方,扇贝,星火,百度,51,能飞,欧洲,叽哩呱啦,宝宝,趣配音,英孚,少儿,人人,日常,常用,开心,在线,voa,bbc,出国,基础,语言,教育,新闻,阅读,练习,宝典,课堂,词场,学霸,软件,大师";
    
    [self saveprogress:str andName:@"0812.json"];
    NSArray *nceArray = [str componentsSeparatedByString:@","];
    return nceArray;
}

- (NSArray *)nceEnglishV {
    NSString *str1 = @"每日,雅思,托福,考研,商务,高考,牛津,有道,懒人,留学,儿童,幼儿,小学,初中,高中,大学,中文,英文,英汉,四级,六级,词典,发音,音标,作业,考试,美剧,大全,达人,题库,旅行,听书,视频,攻略,新东方,星火,金山,百度,51,欧洲,能飞,扇贝,趣配音,沪江,叽哩呱啦,天天,简单,voa,bbc,ted,出国,学霸,少儿,常用,语音,同步,基础,语言,阅读,练习,宝典,软件,课堂,教育,词场";
    //    考试
    [self saveprogress:str1 andName:@"0812V.json"];
    NSArray *nceVArray = [str1 componentsSeparatedByString:@","];
    return nceVArray;
}

- (NSArray *)nceEnglishO {
    NSString *strNCE = @"每日,雅思,托福,考研,金山,商务,高考,牛津,有道,英孚,懒人,留学,儿童,幼儿,小学,初中,高中,大学,中英文,英汉,四级,六级,词典,发音,音标,作业,美剧,大全,题库,旅行,听书,攻略,视频,新东方,扇贝,星火,百度,51,沪江,欧洲,叽哩呱啦,趣配音,人人,日常,常用,少儿,开心,voa,bbc,ted,出国,在线,基础,双语,语音,语言,教育,阅读,练习,宝典,软件,课堂,词场,学霸";
    [self saveprogress:strNCE andName:@"0812O.json"];
    NSArray *nceVArray = [strNCE componentsSeparatedByString:@","] ;
    return nceVArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSArray *nceArrayOrigle = [self nceEnglish];
    NSArray *nceVArrayOrigle = [self nceEnglishV];
    NSArray *nceOArrayOrigle = [self nceEnglishO];
    
    NSMutableArray *nceArray = [nceArrayOrigle mutableCopy];
    NSMutableArray *nceVArray = [nceVArrayOrigle mutableCopy];
    NSMutableArray *nceOArray = [nceOArrayOrigle mutableCopy];
//nce 独有
    [nceArray removeObjectsInArray:nceVArray];
    [nceOArray removeObjectsInArray:nceVArray];
    
//    NSMutableArray *nceOArray = [[str componentsSeparatedByString:@","] mutableCopy];
//    NSMutableArray *nceOArrayOne = [[str1 componentsSeparatedByString:@","] mutableCopy];
//    [nceArray removeObjectsInArray:nceOArray];
//    [nceVArray removeObjectsInArray:nceOArray];
    
    NSLog(@"------%@----%@",nceArray,nceOArray);

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
