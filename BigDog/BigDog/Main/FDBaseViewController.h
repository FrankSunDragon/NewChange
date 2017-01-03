//
//  FDBaseViewController.h
//  JiuZhuang_App
//
//  Created by apple on 14-12-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "FDNotInternetView.h"

@interface FDBaseViewController : UIViewController

/// 设置导航栏标题和 默认图片的左侧返回
- (void)FD_NavigationBarWithTitle:(nullable NSString *)title;

/// 设置导航栏标题 (左侧)自选返回按钮图片 和方法
- (void)FD_NavigationBarWithTitle:(nullable NSString *)titleText LeftBarIMg:(nullable NSString *)IMgName action:(nullable SEL)action;

/// 设置 （右侧）按钮图片和 方法
- (void)FD_NavigationBarWithRightBarIMg:(nullable NSString *)IMgName action:(nullable SEL)action;

///取出导航栏最下面的线
- (UIImageView *)FindNavgationBarBottomLine:(UIView *)view ;

//- (void)FDLoadingStoryboardWithVCName:(NSString *)VCName withStoryboardIdentifier:(NSString *)Identifer;

/**
 *  下拉， 更新最新数据
 *
 */
//- (void)ZMG_update_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action ISautomaticallyRefreshing:(BOOL)ISBegining;
//
///**
// *  上拉， 加载更多数据
// *
// */
//- (void)ZMG_more_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action;

/**
 *  判断用户是否登录
 */
@property (assign, nonatomic) BOOL ISUserLogin;

@property (assign, nonatomic) BOOL IsAlertVIew;


-(void)showAlert:(NSString *)title alertTag:(NSInteger)tag  delegate:(nullable id /*<UIAlertViewDelegate>*/)dele;
// 是否可见
//@property (weak, nonatomic) FDNotInternetView * NOTINternet;

- (UIView *)get_popViewISrootVC:(BOOL)isRootVC;
@end
