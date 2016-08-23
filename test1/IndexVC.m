//
//  IndexVC.m
//  test1
//
//  Created by yangshuo on 16/4/21.
//  Copyright © 2016年 yangshuo. All rights reserved.
//

#import "IndexVC.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
//#import "GTMBase64.h"
//#import "QNUrlSafeBase64.h"
//#import "CocoaSecurity.h"

@interface IndexVC ()

@end

@implementation IndexVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //   UITableView * m_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 776)];
    ////    m_tableView.dataSource = self;
    ////    m_tableView.delegate = self;
    //    m_tableView.showsVerticalScrollIndicator = NO;
    ////    m_tableView.separatorColor = [CommonImage colorWithHexString:LINE_COLOR];
    //    m_tableView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:m_tableView];
    //
    //     NSString * titleBtn = @"LINE 1\n";
    //    UIButton *doubleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    doubleBtn.frame = CGRectMake(0, 100, 320, 150);
    //    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:titleBtn];
    //    NSRange contentRange = {0,[content length]};
    //    [content addAttribute:NSForegroundColorAttributeName
    //                    value:[UIColor redColor]
    //                    range:contentRange];
    //    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    //    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //    [style setAlignment:NSTextAlignmentCenter];
    //    [style setLineBreakMode:NSLineBreakByWordWrapping];
    //    [content addAttribute:NSParagraphStyleAttributeName value:style range:contentRange];
    //
    //
    //    [doubleBtn.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    //    [doubleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    //        doubleBtn.titleLabel.attributedText = content;
    //    [doubleBtn setAttributedTitle:content forState:UIControlStateNormal];
    ////    [doubleBtn addTarget:self action:@selector(setJumpDoubleEvents:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:doubleBtn];
    //    [[doubleBtn titleLabel] setNumberOfLines:0];
    //    [[doubleBtn titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    //    [self convertHtml];
    //    NSString * dbFile = [[[self class] datePath] stringByAppendingPathComponent:@"doubleBook"];
    //    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    //    NSString *dbEmpty = [[self getAppPath] stringByAppendingPathComponent:@"doubleBook.bundle"];
    //    //    [fileManager copyItemAtPath:dbEmpty toPath:dbFile error:nil];
    //    //    [[NSFileManager defaultManager] removeItemAtPath:dbEmpty error:NULL];
    //
    //    NSString *cacheDir = [dbFile stringByAppendingPathComponent:@"double_pic"];
    //    //永久缓存目录
    //    if([fileManager fileExistsAtPath:cacheDir isDirectory:nil])
    //    {
    //        NSArray *files = [fileManager contentsOfDirectoryAtPath:cacheDir error:nil];
    //        //获得缓存文件
    //        for(NSString *file in files)
    //        {
    //            NSString *filePath = [cacheDir stringByAppendingPathComponent:file];
    //            NSArray *filesLessonS = [fileManager contentsOfDirectoryAtPath:filePath error:nil];
    //
    //            for(NSString *filelesson in filesLessonS)
    //            {
    //                NSString *filePathLessonPath = [filePath stringByAppendingPathComponent:filelesson];
    //                NSString *filePathLesson ;
    //            filePathLesson = [filelesson stringByReplacingOccurrencesOfString:@"页面" withString:@""];
    //            filePathLesson = [filePathLesson stringByReplacingOccurrencesOfString:@"图像" withString:@""];
    //                 NSString *filePathLessonPathNew = [filePath stringByAppendingPathComponent:filePathLesson];
    //            //              NSDictionary *attributesDict = [fileManager attributesOfItemAtPath:filePath error:nil];
    //            BOOL state=    [fileManager copyItemAtPath:filePathLessonPath toPath:filePathLessonPathNew error:nil];
    //                if (state) {
    //                    [fileManager removeItemAtPath:filePathLessonPath error:nil];
    //                }
    //
    ////            [self saveFileToDoc:content withFileName:file withPath:cacheDir];
    //            }
    //        }
    //    }
    [self tettstts];
}

//- (NSString *)URLEncoding:(
//{
//    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
#define QINIUSecretKey  @"xZDKcxeZPYeBHa1Vxs92livcxLrF0uoVm8ZI9jTt"
#define QINIUAccessKey  @"7dzkai7pxuPy26rcma_rzoze4wnSHY25MBq9PVUs"
-(void)tettstts
{
//    http://7xt8nl.com2.z0.glb.clouddn.com/img1.png?attname=&e=1461330536&token=cHfHdhVvNZHutxCd3Kz8X7DqbsY834Yx-noq6L6l:nplewGNEjaHwhsg74yZFsVGqIrU
    //    NSString *QINIUURL
    //    long expires = [CommonDate getLongTime] + 60*60;
    //    NSString *baseUrl = [QINIUURL stringByAppendingFormat:@"ly%03ld.mp3??e=%ld",index,(long)expires];
//    NSString *QINIUSecretKey = @"IkVtMv5mhMuhLd-tTUzz5jwGZDgLdXk0ySxuwaaX";
//    NSString *QINIUAccessKey = @"cHfHdhVvNZHutxCd3Kz8X7DqbsY834Yx-noq6L6l";
//    NSString *baseUrl =  @"http://7xt8nl.com2.z0.glb.clouddn.com/img1.png?e=1461330636";
//     NSString *baseUrl = @"http://7xt8nl.com2.z0.glb.clouddn.com/img1.png?attname=&e=1461331270";
//     NSString *QINIUSecretKey = @"MY_SECRET_KEY";
//      NSString *QINIUAccessKey = @"MY_ACCESS_KEY";

    NSString *baseUrl = @"http://7xt7ob.com2.z0.glb.clouddn.com/doubleBook.zip?e=1461330536";
//     NSString *baseUrl = @"http://7xt7ob.com2.z0.glb.clouddn.com/ly002.mp3?e=1461330536";
    baseUrl = [baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *sign = [[self class] hmac_sha1:QINIUSecretKey text:baseUrl];
    NSString *tokden = [QINIUAccessKey stringByAppendingFormat:@":%@",sign];
    NSString *urlString = [baseUrl stringByAppendingFormat:@"&token=%@",tokden];
    NSLog(@"---%@",urlString);
    
    urlString =  [[self class] downloadPathForKey:QINIUSecretKey];
    NSLog(@"---%@",urlString);
}

-(NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString*
    outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                             
                                                                             NULL, /* allocator */
                                                                             
                                                                             (__bridge CFStringRef)input,
                                                                             
                                                                             NULL, /* charactersToLeaveUnescaped */
                                                                             
                                                                             (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                             
                                                                             kCFStringEncodingUTF8);
    
    
    return  outputStr;
}


+ (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text{
    
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
    
    NSString *hash = [QNUrlSafeBase64 encodeData:HMAC];//base64 编码。
    return hash;
}


+ (NSString *)downloadPathForKey:(NSString *)kSecretKey {
    //下载令牌的失效时间
    NSInteger deadline = [[NSDate dateWithTimeIntervalSinceNow:3600] timeIntervalSince1970];
    
    NSString *downloadURL = [NSString stringWithFormat:@"http://developer.qiniu.com/resource/flower.jpg?e=1451491200"];
    
    //加密
    CocoaSecurityResult *result = [CocoaSecurity hmacSha1:downloadURL hmacKey:(NSString * const)kSecretKey];
    
    NSString *encodedSign = [QNUrlSafeBase64 encodeData:result.data];//[result base64];
    
    //拼接令牌
    NSString *downloadToken = [NSString stringWithFormat:@"%@:%@", @"MY_ACCESS_KEY", encodedSign];
    
    //拼接下载URL
    return [NSString stringWithFormat:@"%@&token=%@", downloadURL, downloadToken];
}

//获得当前时间
+ (long)getLongTime
{
    NSDate* now = [NSDate date];
    //    NSLog(@"%@",now);
    unsigned long test = (long)[now timeIntervalSince1970];
    return test;
}
-(void)convertHtml
{
    NSString * dbFile = [[[self class] datePath] stringByAppendingPathComponent:@"doubleBook"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSString *dbEmpty = [[self getAppPath] stringByAppendingPathComponent:@"doubleBook.bundle"];
    //    [fileManager copyItemAtPath:dbEmpty toPath:dbFile error:nil];
    //    [[NSFileManager defaultManager] removeItemAtPath:dbEmpty error:NULL];
    
    NSString *cacheDir = [dbFile stringByAppendingPathComponent:@"double_page"];
    //永久缓存目录
    if([fileManager fileExistsAtPath:cacheDir isDirectory:nil])
    {
        NSArray *files = [fileManager contentsOfDirectoryAtPath:cacheDir error:nil];
        //获得缓存文件
        for(NSString *file in files)
        {
            NSString *filePath = [cacheDir stringByAppendingPathComponent:file];
            NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            content = [content stringByReplacingOccurrencesOfString:@"页面" withString:@""];
            content = [content stringByReplacingOccurrencesOfString:@"图像" withString:@""];
            //              NSDictionary *attributesDict = [fileManager attributesOfItemAtPath:filePath error:nil];
            [fileManager removeItemAtPath:filePath error:nil];
            [self saveFileToDoc:content withFileName:file withPath:cacheDir];
        }
    }
}

-(void)saveFileToDoc:(NSString*)docData  withFileName:(NSString *)fileName withPath:(NSString *)docPath
{
    //    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //        NSString* docPath = docPath;
        //    NSString* docPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSLog(@"%@", docPath);
        NSString* Json_path = [docPath stringByAppendingPathComponent:fileName];
        //==写入文件
        NSData* contentData = [docData dataUsingEncoding:NSUTF8StringEncoding];
        if ([contentData writeToFile:Json_path atomically:YES]) {
            NSLog(@"写入文件成功 %@", Json_path);
        } else {
            NSLog(@"写入文件失败 %@", Json_path);
        }
    });
}

//路径
+ (NSString*)datePath
{
    return [NSString stringWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]];
}
-(NSString*)getAppPath//得到数据库文件在App目录下的路径
{
    return [[NSBundle mainBundle] resourcePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
