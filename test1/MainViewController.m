//
//  MainViewController.m
//  test1
//
//  Created by yangshuo on 14-5-3.
//  Copyright (c) 2014年 yangshuo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    UILabel *label;
    int frontSize;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    frontSize = 14;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 60, 30);
    [btn setTitle:@"+++" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    btn.tag = 1;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(200, 100, 60, 30);
    btn1.tag = 2;
    [btn1 setTitle:@"---" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(100, 140, 60, 30)];
    label.text = @"测试";
    label.font = [UIFont systemFontOfSize:frontSize];
    [self.view addSubview:label];
    

}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 1)
    {
         label.font = [UIFont systemFontOfSize:frontSize++];
    }
   else
   {
       label.font = [UIFont systemFontOfSize:frontSize--];
   }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
