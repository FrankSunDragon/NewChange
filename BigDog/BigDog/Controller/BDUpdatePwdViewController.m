//
//  BDUpdatePwdViewController.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/9.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "BDUpdatePwdViewController.h"
#import "RansomTFd.h"

@interface BDUpdatePwdViewController ()
@property (weak, nonatomic) IBOutlet RansomTFd *oldPwdTFd;
@property (weak, nonatomic) IBOutlet RansomTFd * newpwdTFd;
@property (weak, nonatomic) IBOutlet RansomTFd *tryAgainTFd;
@property (weak, nonatomic) IBOutlet RansomTFd *userTFd;

@end

@implementation BDUpdatePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubviews];
    
}
- (void)setUpSubviews{
    [self FD_NavigationBarWithTitle:@"更新密码"];
    _userTFd.leftLabText = @"用户名:";
    _oldPwdTFd.leftLabText = @"原密码:";
    _newpwdTFd.leftLabText = @"新密码:";
    _tryAgainTFd.leftLabText = @"Try Again:";
}


- (IBAction)sureClick:(id)sender {
    if([self judgmentCondition]) return;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"un"] = [SecurityUtil encryptAESData:_userTFd.text secretKey:BigDogArr[3]];
    
    NSString * oldPwd = [[[_userTFd.text stringByAppendingString:_oldPwdTFd.text] lowercaseString] md5String];
    dict[@"oldpwd"] = [SecurityUtil encryptAESData:oldPwd secretKey:BigDogArr[4]];
    
    
    NSString * ss = [[[_userTFd.text stringByAppendingString:_newpwdTFd.text] lowercaseString] md5String];
    dict[@"pwd"] = [SecurityUtil encryptAESData:ss secretKey:BigDogArr[5]];
    
    
    [AFNetWorkingGet GET_RequestWithAlertView:bd_updatePwd params:dict isHUD:YES isAlert:YES completion:^(id result) {
        NSLog(@"%@",result);
        
        if(![result[@"errorCode"] boolValue]){//更新密码
            [DRHProgressHUD FDShowClock:@"更新密码成功"];
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
    else if (_oldPwdTFd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"请输入原密码"];
        return YES;
    }
    else if(![_newpwdTFd.text isEqualToString:_tryAgainTFd.text] || _newpwdTFd.text.length == 0){
        [DRHProgressHUD FDShowClock:@"两次密码不一致"];
        return YES;
    }
    return NO;
}
@end
