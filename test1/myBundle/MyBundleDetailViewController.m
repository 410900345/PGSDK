//
//  MyBundleDetailViewController.m
//  JingNi
//
//  Created by yangshuo on 13-12-27.
//  Copyright (c) 2013年 com.pixolity. All rights reserved.
//

#import "MyBundleDetailViewController.h"
#import "Gauge.h"

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
        [wordDict setObject:@0 forKey:word];
    }
    for (NSArray *dict in rootDict) {
        NSString *str = dict[0];
        for (NSString *subStr in arryKyword) {
            if ([str containsString:subStr]){
                NSInteger num = [wordDict[subStr] integerValue];
                num ++;
                [wordDict setObject:@(num) forKey:subStr];
            }
        }
    }
    
    NSMutableArray *numArray = [NSMutableArray array];
    for (NSString *subStr in arryKyword) {
        NSInteger num = [wordDict[subStr] integerValue];
        [numArray addObject:@(num)];
//      NSLog(@"-----%@-----%ld ",subStr,num);
    }
    NSLog(@"-----%@ ",arryKyword);
    NSLog(@"-----%@- ",numArray);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self creatMyNavgationbar];
  
    NSString *str = @"日常,天天,voa,一起,新东方,爽哥,懒人,有道,百度,流利说,华尔街,多说,能飞,少儿,在线,基础,英文,走遍,美国,出国,留学,学堂,学霸,背单词,学英语,同步,趣配音,宝典,词场,免费,软件";
    [self saveprogress:str andName:@"newNce.json"];

     NSString *str1 = @"日常,天天,voa,一起,新东方,爽哥,懒人,有道,百度,流利说,华尔街,多说,能飞,少儿,在线,基础,英文,走遍,美国,出国,留学,学堂,学霸,背单词,学英语,同步,趣配音,宝典,词场,免费,软件";
    [self saveprogress:str andName:@"nce1.json"];
    
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
