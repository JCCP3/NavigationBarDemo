//
//  ThirdViewController.m
//  NavigationBarDemo
//
//  Created by JC_CP3 on 15/7/20.
//  Copyright (c) 2015年 JC_CP3. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //样式为左边有一个 右边有两个
//    [self adaptLeftRightBtnAlive:64.f withHeaderViewBg:@"#ff0000" withIsShowLeftImageAndTitle:YES withLeftImage:[UIImage imageNamed:@"nav_back"] withLeftTitle:@"返回" withNavTitle:@"你猜" withIsTwoRightBtn:YES withRightImage:[UIImage imageNamed:@"nav_left_side"] withRightTitle:nil withSecRightImage:[UIImage imageNamed:@"nav_right_side"] withSecRightTitle:nil withSegmentArray:@[@"第一项",@"第二项",@"第三项"]];
    
    [self adaptHeaderViewWithHeight:64.f HeaderViewBgTag:CustomNavigationBarColorRed NavTitle:@"第三种样式" SegmentArray:@[@"第一项",@"第二项",@"第三项"]];
    
    [self adaptHeaderViewWithLeftAliveSetting:YES withLeftImageAndTitleAlive:YES RightAlive:YES];
    
    [self adaptHeaderViewWithLeftImage:[UIImage imageNamed:@"nav_back"] LeftTitle:@"返回" RightImage:@[[UIImage imageNamed:@"nav_left_side"],[UIImage imageNamed:@"nav_right_side"]] RightTitle:nil];
    
}

- (void)didReceiveMemoryWarning {
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

-(void)onClickLeftBtn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
