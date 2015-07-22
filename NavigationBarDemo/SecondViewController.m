//
//  SecondViewController.m
//  NavigationBarDemo
//
//  Created by JC_CP3 on 15/7/20.
//  Copyright (c) 2015年 JC_CP3. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //适配导航条 左边为图片＋文字  右边为图片
    [self adaptHeaderViewWithHeight:64.f bgTag:CustomNavigationBarColorRed navTitle:@"追书神器" segmentArray:nil];
    [self adaptHeaderViewWithLeftAliveSetting:YES leftTitleAndImageAlive:YES rightAlive:YES];
    [self adaptHeaderViewWithLeftImage:[UIImage imageNamed:@"nav_back"] leftTitle:@"返回" rightImage:@[[UIImage imageNamed:@"nav_left_side"],[UIImage imageNamed:@"nav_right_side"]] rightTitle:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 重写点击方法
- (void)onClickLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickRightBtn{
    ThirdViewController *viewController = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
