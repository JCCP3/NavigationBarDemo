//
//  MainViewController.m
//  NavigationBarDemo
//
//  Created by JC_CP3 on 15/7/20.
//  Copyright (c) 2015年 JC_CP3. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "BaseNavController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //左右均为图片
    [self adaptHeaderViewWithHeight:64.f bgTag:CustomNavigationBarColorRed navTitle:@"追书神器" segmentArray:nil];
    [self adaptHeaderViewWithLeftAliveSetting:YES leftTitleAndImageAlive:NO rightAlive:YES];
    [self adaptHeaderViewWithLeftImage:[UIImage imageNamed:@"nav_left_side"] leftTitle:nil rightImage:@[[UIImage imageNamed:@"nav_right_side"]] rightTitle:nil];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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

- (IBAction)onClickShowNextStyle:(id)sender {
    
    SecondViewController *viewController = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)onClickShowThirdStyle:(id)sender {
    
    ThirdViewController *viewController = [[ThirdViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (IBAction)onClickShowForthStyle:(id)sender {
}



- (void)onClickLeftBtn{
    
    SecondViewController *viewController = [[SecondViewController alloc] init];
    BaseNavController *navController = [[BaseNavController alloc] initWithRootViewController:viewController];
    navController.enableBackGesture = YES;
    [self presentViewController:navController animated:YES completion:nil];
    
}

@end
