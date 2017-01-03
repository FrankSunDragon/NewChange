//
//  FDNavigationController.m
//  FTAgreement
//
//  Created by syf on 15/10/26.
//  Copyright (c) 2015年 SYF. All rights reserved.
//

#import "FDNavigationController.h"

@interface FDNavigationController ()

@end

@implementation FDNavigationController

/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
    [self setupNavBarTheme];
    // 2.设置导航栏按钮主题
    [self setupBarButtonItemTheme];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * lineIMg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 0.5)];
    //dbdbdb
    lineIMg.backgroundColor =DRHColor(224, 224, 224);
    [self.navigationBar addSubview:lineIMg];
    self.navigationBar.tintColor = [UIColor blackColor];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

//  设置 （left right）按钮 主题
+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] =  DRHColor(233, 73, 71);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    disableTextAttrs[NSForegroundColorAttributeName] =  DRHColor(224, 224, 224);
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}


- (void)setUpNavigationBar:(NSString *)titleText
{
    self.title = titleText;
}


/**
 *  设置 导航栏 主题
 */
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    if([[UIDevice currentDevice].systemVersion doubleValue]>=8.0)
      navBar.translucent = YES;
    // 设置导航栏的被禁颜色属性
 // navBar.barTintColor = [SYFCustomCLASS SYFColorChange:@"#f8f8f8"];
    navBar.barTintColor = [UIColor whiteColor];
    
    // 设置文字的属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:17];
    [navBar setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

@end
