//
//  BDLoginViewController.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/1.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "BDLoginViewController.h"
#import "BDHomeTableController.h"
#import "BDRegisterViewController.h"
#import "BDUpdatePwdViewController.h"
#import "RansomTFd.h"

@interface BDLoginViewController ()
@property (weak, nonatomic) IBOutlet RansomTFd *userTfd;
@property (weak, nonatomic) IBOutlet RansomTFd *pwdTfd;

@end

@implementation BDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPNavigationBar];

    
}


-(void)setUPNavigationBar{
    _userTfd.leftLabText = @"用户名:";
    _pwdTfd.leftLabText = @"密码:";


}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

}


#pragma mark ++++++++++++
#pragma mark 点击注册按钮
- (IBAction)registerClick:(UIButton *)sender {
    
    BDRegisterViewController * VC = [[BDRegisterViewController alloc] initWithNibName:@"BDRegisterViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark ++++++++++++
#pragma mark 点击登录按钮
- (IBAction)loginClick:(UIButton *)sender {
    if(_userTfd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"请输入用户名"];
        return;
    }
    else if(_pwdTfd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"请输入密码"];
        return;
    }
    
    BDHomeTableController * homeVC = [[BDHomeTableController alloc] initWithNibName:@"BDHomeTableController" bundle:nil];
    FDNavigationController * nav = [[FDNavigationController alloc] initWithRootViewController:homeVC];
    [GlobalVariables shareGlobalVariables].username = _userTfd.text;
    [GlobalVariables shareGlobalVariables].pwd = _pwdTfd.text;
    
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    
    
}



#pragma mark ++++++++++++
#pragma mark  修改用户密码
- (IBAction)updatePwdClick:(id)sender {
    BDUpdatePwdViewController * VC = [[BDUpdatePwdViewController alloc] initWithNibName:@"BDUpdatePwdViewController" bundle:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

@end
