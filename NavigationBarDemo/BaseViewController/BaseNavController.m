//
//  BaseNavController.m
//  NavigationBarDemo
//
//  Created by JC_CP3 on 15/7/21.
//  Copyright (c) 2015年 JC_CP3. All rights reserved.
//

#import "BaseNavController.h"
#import "BaseViewController.h"
#import <objc/runtime.h>

static const char *assoKeyPanGesture="__yrakpanges";
static const char *assoKeyStartPanPoint="__yrakstartp";
static const char *assoKeyEnableGesture="__yrakenabg";

@interface BaseNavController (){
    
    
}

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = self;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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

#pragma mark 重写UInavigationController方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [super pushViewController:viewController animated:animated];
    
}


#pragma mark UINavigaionControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    /* if rootViewController, set delegate nil */
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
    UIViewController *currentVC = [self topViewController];
    ((BaseViewController *)currentVC).shadowView.alpha = DEVICE_AVALIABLE_WIDTH/1000;
    ((BaseViewController *)currentVC).shadowView.hidden = YES;
    
    
    int count = (int)[self.viewControllers count];
    if(count > 1){
        
        UIViewController *preVC = [self.viewControllers objectAtIndex:count-2];
        ((BaseViewController *)preVC).shadowView.alpha = DEVICE_AVALIABLE_WIDTH/1000;
        
        ((BaseViewController *)currentVC).shadowView.hidden = YES;
        
    }
    
}


/* 实现UINavigationController 手势滑动 */
- (BOOL)enableBackGesture
{
    NSNumber *enableGestureNum = objc_getAssociatedObject(self, assoKeyEnableGesture);
    if (enableGestureNum) {
        return [enableGestureNum boolValue];
    }
    return false;
}

- (void)setEnableBackGesture:(BOOL)enableBackGesture
{
    NSNumber *enableGestureNum = [NSNumber numberWithBool:enableBackGesture];
    objc_setAssociatedObject(self, assoKeyEnableGesture, enableGestureNum, OBJC_ASSOCIATION_RETAIN);
    if (enableBackGesture) {
        [self.view addGestureRecognizer:[self panGestureRecognizer]];
    }else{
        [self.view removeGestureRecognizer:[self panGestureRecognizer]];
    }
}

- (UIPanGestureRecognizer *)panGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, assoKeyPanGesture);
    if (!panGestureRecognizer) {
        panGestureRecognizer=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panToBack:)];
        [panGestureRecognizer setDelegate:self];
        objc_setAssociatedObject(self, assoKeyPanGesture, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN);
    }
    return panGestureRecognizer;
}
- (void)setStartPanPoint:(CGPoint)point
{
    NSValue *startPanPointValue = [NSValue valueWithCGPoint:point];
    objc_setAssociatedObject(self, assoKeyStartPanPoint, startPanPointValue, OBJC_ASSOCIATION_RETAIN);
}

- (CGPoint)startPanPoint
{
    NSValue *startPanPointValue = objc_getAssociatedObject(self, assoKeyStartPanPoint);
    if (!startPanPointValue) {
        return CGPointZero;
    }
    return [startPanPointValue CGPointValue];
}

- (void)panToBack:(UIPanGestureRecognizer*)pan
{
    UIView *currentView=self.topViewController.view;
    if (self.panGestureRecognizer.state==UIGestureRecognizerStateBegan) {
        [self setStartPanPoint:currentView.frame.origin];
        CGPoint velocity=[pan velocityInView:self.view];
        if(velocity.x!=0){
            [self willShowPreViewController];
        }
        return;
    }
    CGPoint currentPostion = [pan translationInView:self.view];
    CGFloat xoffset = [self startPanPoint].x + currentPostion.x;
    CGFloat yoffset = [self startPanPoint].y + currentPostion.y;
    if (xoffset>0) {
        //向右滑
        
    }else if(xoffset<0){//向左滑
        xoffset = 0;
    }
    if (!CGPointEqualToPoint(CGPointMake(xoffset, yoffset), currentView.frame.origin)) {
        [self layoutCurrentViewWithOffset:UIOffsetMake(xoffset, yoffset)];
    }
    if (self.panGestureRecognizer.state==UIGestureRecognizerStateEnded) {
        if (currentView.frame.origin.x==0) {
        }else{
            if (currentView.frame.origin.x<BackGestureOffsetXToBack){
                [self hidePreViewController];
            }else{
                [self showPreViewController];
            }
        }
    }
}

- (void)willShowPreViewController
{
    NSInteger count=self.viewControllers.count;
    if (count>1) {
        UIViewController *currentVC = [self topViewController];
        UIViewController *preVC = [self.viewControllers objectAtIndex:count-2];
        [currentVC.view.superview insertSubview:preVC.view belowSubview:currentVC.view];
    }
}

- (void)showPreViewController
{
    NSInteger count = self.viewControllers.count;
    if (count>1) {
        UIView *currentView = self.topViewController.view;
        NSTimeInterval animatedTime = 0;
        animatedTime = ABS(self.view.frame.size.width - currentView.frame.origin.x) / self.view.frame.size.width * 0.35;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:animatedTime animations:^{
            [self layoutCurrentViewWithOffset:UIOffsetMake(self.view.frame.size.width, 0)];
        } completion:^(BOOL finished) {
            [self popViewControllerAnimated:false];
        }];
    }
}

- (void)hidePreViewController
{
    NSInteger count = self.viewControllers.count;
    if (count>1) {
        UIViewController *preVC = [self.viewControllers objectAtIndex:count-2];
        UIView *currentView = self.topViewController.view;
        NSTimeInterval animatedTime = 0;
        animatedTime = ABS(self.view.frame.size.width - currentView.frame.origin.x) / self.view.frame.size.width * 0.35;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:animatedTime animations:^{
            [self layoutCurrentViewWithOffset:UIOffsetMake(0, 0)];
        } completion:^(BOOL finished) {
            ((BaseViewController *)preVC).shadowView.hidden = YES;
            ((BaseViewController *)preVC).shadowView.alpha = DEVICE_AVALIABLE_WIDTH/1000;
            [preVC.view removeFromSuperview];
        }];
    }
}

- (void)layoutCurrentViewWithOffset:(UIOffset)offset
{
    NSInteger count = self.viewControllers.count;
    if (count>1) {
        UIViewController *currentVC = [self topViewController];
        UIViewController *preVC = [self.viewControllers objectAtIndex:count-2];
        [currentVC.view setFrame:CGRectMake(offset.horizontal, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
        ((BaseViewController *)preVC).shadowView.hidden = NO;
        ((BaseViewController *)preVC).shadowView.alpha = (DEVICE_AVALIABLE_WIDTH-offset.horizontal)/1000;
        
        [preVC.view setFrame:CGRectMake(offset.horizontal/2-self.view.frame.size.width/2, self.view.bounds.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.panGestureRecognizer) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        if ([panGesture velocityInView:self.view].x < 600 && ABS(translation.x)/ABS(translation.y)>1) {
            return true;
        }
        return false;
    }
    
    return true;
}


@end
