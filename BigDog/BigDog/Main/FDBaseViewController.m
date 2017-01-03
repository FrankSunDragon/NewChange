//
//  FDBaseViewController.m
//  JiuZhuang_App
//
//  Created by apple on 14-12-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FDBaseViewController.h"
#import "BDLoginViewController.h"
#import "SYFCustomVIEW.h"
//#import "FDRefreshBackFooter.h"
#import "FDNavigationController.h"



@interface FDBaseViewController ()<UIGestureRecognizerDelegate,UIAlertViewDelegate>

@end

@implementation FDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    // 设置背景颜色
    //self.view.backgroundColor =DRHColor(245, 245, 245);
    
   // [self setUpNotInternetView];
}

//- (void)setUpNotInternetView{
//    FDNotInternetView *  internetVIew =  [[FDNotInternetView alloc] initWithFrame:CGRectMake(0, 60, SYFWidth, SYFHeight-60)];
//     self.NOTINternet = internetVIew;
//    [self.view sendSubviewToBack:internetVIew];
// }



- (void)FD_NavigationBarWithTitle:(NSString *)title
{
    self.title = title;
   // [self GestureBackperiousVC];
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
   //   [self GestureBackperiousVC];
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

- (UIImageView *)FindNavgationBarBottomLine:(UIView *)view{
    for (UIImageView *subview in view.subviews) {
        // NSLog(@"%@,%@",NSStringFromCGRect(subview.frame),[subview class]);
        if(subview.frame.size.height == 64){
            for (UIImageView *line in subview.subviews){
//                NSLog(@"%@,%@",NSStringFromCGRect(line.frame),[subview superclass]);
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

- (void)setIsAlertVIew:(BOOL)IsAlertVIew{
    
   }



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0) return;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    FDNavigationController * nav  = (FDNavigationController*)[storyboard instantiateViewControllerWithIdentifier:@"NavLogin"];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark ++++++++++++
#pragma mark 用户登录事件
- (void)UserLoginEvent{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    FDNavigationController * nav  = (FDNavigationController*)[storyboard instantiateViewControllerWithIdentifier:@"NavLogin"];
    [self presentViewController:nav animated:YES completion:nil];
}

//
//- (void)ZMG_update_DataRefreshByScrollview:(UIScrollView *)scroll   Target:(nullable id)target action:(SEL)action ISautomaticallyRefreshing:(BOOL)ISBegining{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
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
//}

//- (void)ZMG_more_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action{
//    
//    // 添加默认的上拉刷新
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
//    FDRefreshBackFooter * footer = [FDRefreshBackFooter  footerWithRefreshingTarget:self refreshingAction:action];
//    //MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:action];
//    
////    // 设置文字
////    [footer setTitle:@"" forState:MJRefreshStateIdle];
////    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
////    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
//    
//  //  footer.refreshingTitleHidden = YES;
//    
//    // 设置footer
//    scroll.mj_footer = footer;
//}


#pragma mark  ++++++++++++
#pragma mark  下拉加载gif 动画
- (void)loadCBZ{
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:target refreshingAction:action];
//    
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
//    
//    // 马上进入刷新状态
//    if(ISBegining)
//        [header beginRefreshing];
//    
//    // 设置header
//    scroll.mj_header = header;
//    scroll.mj_header.automaticallyChangeAlpha = YES;
}



-(void)showAlert:(NSString *)title alertTag:(NSInteger)tag delegate:(nullable id /*<UIAlertViewDelegate>*/)dele
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:dele cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    alertView.tag = tag;
    [alertView show];
}


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [DRHProgressHUD FDDissHUD];
//    [DRHProgressHUD FDDissHUDForView:self.view];
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [DRHProgressHUD FDDissHUD];
    [DRHProgressHUD FDDissHUDForView:self.view];

}


- (UIView *)get_popViewISrootVC:(BOOL)isRootVC{
    if([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        NSUInteger index = 0;
        if(!isRootVC)
        index = self.navigationController.viewControllers.count - 1;
        UIViewController * vc = self.navigationController.viewControllers[index];
        return vc.view;
    }
    return nil;
}

@end
