//
//  BDRegisterViewController.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/2.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "BDRegisterViewController.h"
#import "RansomTFd.h"
@interface BDRegisterViewController ()
@property (weak, nonatomic) IBOutlet RansomTFd *userTFd;
@property (weak, nonatomic) IBOutlet RansomTFd * newpwdTFd;
@property (weak, nonatomic) IBOutlet RansomTFd *oldPwdTFd;

@end

@implementation BDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
}


- (void)setUpSubviews{
    [self FD_NavigationBarWithTitle:@"注册"];
    _userTFd.leftLabText = @"用户名:";
    _newpwdTFd.leftLabText = @"新密码:";
    _oldPwdTFd.leftLabText = @"NextPwd:";
}


- (IBAction)sureClick:(id)sender {
    if([self judgmentCondition]) return;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"un"] = [SecurityUtil encryptAESData:_userTFd.text secretKey:BigDogArr[3]];
    NSString * ss = [[[_userTFd.text stringByAppendingString:_newpwdTFd.text] lowercaseString] md5String];
    dict[@"pwd"] = [SecurityUtil encryptAESData:ss secretKey:BigDogArr[4]];

    
    [AFNetWorkingGet GET_RequestWithAlertView:bd_register params:dict isHUD:YES isAlert:YES completion:^(id result) {
        NSLog(@"%@",result);

        if(![result[@"errorCode"] boolValue]){//注册成功
            [DRHProgressHUD FDShowClock:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
            [DRHProgressHUD FDShowClock:result[@"errorMsg"]];
    } failure:^(NSError * error) {
      } connect:^(BOOL connect) {
    }];
  }


#pragma mark ++++++++++++
#pragma mark 判断请求条件
- (BOOL)judgmentCondition{
    if(_userTFd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"应户名不能为空"];
        return YES;
    }
    else if (_newpwdTFd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"请输入密码"];
        return YES;
    }
    else if(![_newpwdTFd.text isEqualToString:_oldPwdTFd.text]){
        [DRHProgressHUD FDShowClock:@"两次密码不一致"];
        return YES;
    }
    return NO;
}

@end
