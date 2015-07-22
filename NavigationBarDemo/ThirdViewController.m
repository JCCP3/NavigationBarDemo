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
    [self adaptHeaderViewWithHeight:64.f bgTag:CustomNavigationBarColorRed navTitle:@"追书神器" segmentArray:@[@"第一项",@"第二项",@"第三项"]];
    [self adaptHeaderViewWithLeftAliveSetting:YES leftTitleAndImageAlive:YES rightAlive:YES];
    [self adaptHeaderViewWithLeftImage:[UIImage imageNamed:@"nav_back"] leftTitle:@"返回" rightImage:@[[UIImage imageNamed:@"nav_left_side"],[UIImage imageNamed:@"nav_right_side"]] rightTitle:nil];
    
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
