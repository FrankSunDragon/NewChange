//
//  FDBaseTableViewController.h
//  JackyLeLe
//
//  Created by syf on 15/8/20.
//  Copyright (c) 2015年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDBaseTableViewController : UITableViewController

/// 设置导航栏标题和 默认图片的左侧返回
- (void)FD_NavigationBarWithTitle:(NSString *)title;

/// 设置导航栏标题 (左侧)自选返回按钮图片 和方法
- (void)FD_NavigationBarWithTitle:(NSString *)titleText LeftBarIMg:(NSString *)IMgName action:(SEL)action;

/// 设置 （右侧）按钮图片和 方法
- (void)FD_NavigationBarWithRightBarIMg:(NSString *)IMgName action:(SEL)action;

/// 取出导航栏最下面的线
- (UIImageView *)FindNavgationBarBottomLine:(UIView *)view ;

/**
 *  下拉， 更新最新数据
 *
 */
- (void)ZMG_update_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action ISautomaticallyRefreshing:(BOOL)ISBegining;

/**
 *  上拉， 加载更多数据
 *
 */
- (void)ZMG_more_DataRefreshByScrollview:(nullable UIScrollView *)scroll   Target:(nullable id)target action:(nullable SEL)action;

/**
 *  判断用户是否登录
 */
@property (assign, nonatomic) BOOL ISUserLogin;


@property (assign, nonatomic) BOOL IsAlertVIew;

@end
