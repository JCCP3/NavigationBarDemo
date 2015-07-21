//
//  BaseViewController.h
//  NavigationBarDemo
//
//  Created by JCCP3 on 15/7/20.
//  Copyright (c) 2015年 JCCP3. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CustomNavigationBarColorRed = 1,
    CustomNavigationBarColorWhite,
    CustomNavigationBarColorLightWhite,
    CustomNavigationBarColorBlack
    
}CustomNavigationBarColorTag;

@interface BaseViewController : UIViewController


//设置基本信息 （高度 背景颜色 segment数组）
- (void)adaptHeaderViewWithHeight:(CGFloat)headerViewHeight HeaderViewBgTag:(CustomNavigationBarColorTag)headerViewBgTag NavTitle:(NSString *)navTitle SegmentArray:(NSArray *)segmentArray;

//设置tag (判定左右按钮是否存在)
- (void)adaptHeaderViewWithLeftAliveSetting:(BOOL)leftAlive withLeftImageAndTitleAlive:(BOOL)leftImageAndTitleAlive RightAlive:(BOOL)rightAlive;

//设置左右Image和Title
- (void)adaptHeaderViewWithLeftImage:(UIImage *)leftImage LeftTitle:(NSString *)leftTitle RightImage:(NSArray *)rightImageArray RightTitle:(NSArray *)rightTitleArray;

//点击左边按钮
- (void)onClickLeftBtn;

//点击右边第一个按钮
- (void)onClickRightBtn;

//点击右边第二个按钮
- (void)onClickSecRightBtn;

//点击segment
- (void)onClickSegment:(UISegmentedControl *)segmentControl;


@end
