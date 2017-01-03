//
//  FDBaseTableViewController.m
//  JackyLeLe
//  Created by syf on 15/8/20.
//  Copyright (c) 2015年 SYF. All rights reserved.
//

#import "FDBaseTableViewController.h"
#import "SYFCustomVIEW.h"
#import "FDNavigationController.h"

//#import "FDRefreshBackFooter.h"
@interface FDBaseTableViewController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>

@end

@implementation FDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.automaticallyAdjustsScrollViewInsets =NO;
     self.view.backgroundColor = DRHColor(245, 245, 245);
  }

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)FD_NavigationBarWithTitle:(NSString *)title
{
    self.navigationItem.title = title;
//    [self GestureBackperiousVC];
    UIButton * backBtn = [self SYFNEWBarButton:@"icon_back" WithISLeft:YES];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backBtn addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)FD_NavigationBarWithTitle:(NSString *)titleText LeftBarIMg:(NSString *)IMgName action:(SEL)action
{
    self.navigationItem.title = titleText;
    UIButton * backBtn = [self SYFNEWBarButton:IMgName WithISLeft:YES];
    backBtn.adjustsImageWhenHighlighted = NO;
  //  [self GestureBackperiousVC];
    [backBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)FD_NavigationBarWithRightBarIMg:(NSString *)IMgName action:(SEL)action
{
    UIButton * backBtn = [SYFCustomVIEW SYFNEWBarButton:IMgName WithISLeft:YES];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.rightBarButtonItem = backItem;
}

- (UIButton *)SYFNEWBarButton: (NSString *)imageStr WithISLeft:(BOOL)isPianyi
{
    UIButton *  navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navLeftButton.frame = CGRectMake(0, 0, 44, 44);
    //  navLeftButton.backgroundColor = [UIColor lightGrayColor];
    [navLeftButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    navLeftButton.imageEdgeInsets = UIEdgeInsetsMake(-13 , -30, -13, 0);
    return navLeftButton;
}

- (void)BackBtnClick
{
  if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImageView *)FindNavgationBarBottomLine:(UIView *)view
{
    for (UIImageView *subview in view.subviews) {
        // NSLog(@"%@,%@",NSStringFromCGRect(subview.frame),[subview class]);
        if(subview.frame.size.height == 64){
            for (UIImageView *line in subview.subviews){
//                NSLog(@"%@,%@",NSStringFromCGRect(line.frame),[line class]);
                if(line.frame.size.height <=1)
                    return line;
            }
        }
    }
    return nil;
}

//// 设置手势返回的犯法
//- (void)GestureBackperiousVC
//{
//    if (FTAMobileSystemVersion>= 7.0) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//    }
//}

- (void)setISUserLogin:(BOOL)ISUserLogin
{
    if(ISUserLogin)
        return;
    else{
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        FDNavigationController * nav  = (FDNavigationController*)[storyboard instantiateViewControllerWithIdentifier:@"NavLogin"];
        [self presentViewController:nav animated:YES completion:^{
            // self.navigationController.navigationBarHidden = NO;
        }];
    }
}

//
- (void)ZMG_update_DataRefreshByScrollview:(UIScrollView *)scroll   Target:(nullable id)target action:(SEL)action ISautomaticallyRefreshing:(BOOL)ISBegining{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
//    
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    header.automaticallyChangeAlpha = YES;
//    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 马上进入刷新状态
//    if(ISBegining)
//        [header beginRefreshing];
//    
//    // 设置header
//    scroll.mj_header = header;
//    scroll.mj_header.automaticallyChangeAlpha = YES;
}


- (void)ZMG_more_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action{
   //  FDRefreshBackFooter * footer = [FDRefreshBackFooter  footerWithRefreshingTarget:self refreshingAction:action];
//    // 添加默认的上拉刷新
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:action];
//    
//    // 设置文字
//    [footer setTitle:@"" forState:MJRefreshStateIdle];
//    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
//    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    
//    footer.refreshingTitleHidden = YES;
//    scroll.mj_footer.automaticallyHidden = YES;
    // 设置footer
   // scroll.mj_footer = footer;
}

- (void)setIsAlertVIew:(BOOL)IsAlertVIew{
  }


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) return;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FDNavigationController * nav  = (FDNavigationController*)[storyboard instantiateViewControllerWithIdentifier:@"NavLogin"];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
