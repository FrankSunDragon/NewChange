//
//  AFNetWorkingGet.m
//  Dronghui
//
//  Created by 马博 on 16/1/6.
//  Copyright © 2016年 dongronghui. All rights reserved.
//

#import "AFNetWorkingGet.h"
#import "Reachability.h"
#import "DRHProgressHUD.h"
@implementation AFNetWorkingGet

+ (void)GET_RequestWithAlertView:(NSString *)url params:(NSDictionary *)params isHUD:(BOOL)isNeedHUD isAlert:(BOOL)isAlert completion:(void (^)(id))success failure:(void (^)(NSError *))failure connect:(void (^)(BOOL))IsAvailable{
    
    //1. 检测网络
    BOOL  intenet = [Reachability isMayUseInternet];
    
    if(IsAvailable){// 回调网络状态
        IsAvailable(!intenet);
    }
    if(intenet){// M没有网
        
    if(isAlert)
     [DRHProgressHUD FDShowClock:@"网络不给力，请稍后再试"];
        return;
    }
    
    if(isNeedHUD)
    [DRHProgressHUD FDLoadingNetworkRequest:nil];
    
    //  创建请求管理
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    // 设置响应解析对象
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 支持类型
    [manage.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/plain", nil]];
    
    // 设置超时时间
    [manage.requestSerializer willChangeValueForKey:@"timeoutInterval"];
     manage.requestSerializer.timeoutInterval = 15.f;
    [manage.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:params];
    // 获取当前时间
    NSDateFormatter * matter = [[NSDateFormatter alloc] init];
    [matter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeStr = [matter stringFromDate:[NSDate date]];
    dict[@"t"] = [SecurityUtil encryptAESData:timeStr secretKey:BigDogArr[0]];
    
    //版本号
    dict[@"v"] = [SecurityUtil encryptAESData:@"1.0" secretKey:BigDogArr[1]];
    
    dict[@"i"] = [SecurityUtil encryptAESData:@"zh-CN" secretKey:BigDogArr[2]];
    
    
    
     //  NSLog(@"Get-----%@",strAdd);
    
    [manage POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(isNeedHUD)
        {
            [DRHProgressHUD FDDissHUD];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
                
            }else
                NSLog(@"data is empty");
        });
        

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        NSLog(@"请求失败,may be request time out");
        if(isNeedHUD)
            [DRHProgressHUD FDDissHUD];

    }];
  

}



//判断网络连接
+ (BOOL)IntertReachStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    return manager.isReachable;
}




+(void)DRH_loadImg_post:(NSString *)url image:(UIImage *)image success:(void (^)(id))success failure:(void (^)(NSError *))failure connect:(void (^)(BOOL))IsAvailable{
    //1. 检测网络
    BOOL  intenet = [Reachability isMayUseInternet];
    
    if(IsAvailable){
        IsAvailable(!intenet);
    }
    if(intenet){
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"网络不给力！刷新试试~" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }

    // 4.创建请求管理者
    //    创建请求管理
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //    设置响应解析对象
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    //        //默认返回JSON类型（可以不写）
    //        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    //        //设置返回类型
    //        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    // 设置超时时间
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15.f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
  
    [mgr POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        // body 的名字
        [formData appendPartWithFileData:data name:@"body" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)DRH_general_post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable{
       //1. 检测网络
        BOOL  intenet = [self IntertReachStatus];
        if(IsAvailable){
            IsAvailable(!intenet);
        }
        if(intenet != NO)
            return;
    
    // 4.创建请求管理者
    //  创建请求管理
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    //    设置响应解析对象
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(result);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
}


/**
 *  返回当前网络状况
 *
 *  @return yes 代表有网，no代表无网
 */
+ (BOOL)DRH_currentNetworkStatus{
    //1. 检测网络
    BOOL  intenet = [Reachability isMayUseInternet];
   
    if(intenet){
        [DRHProgressHUD FDShowClock:@"网络不给力，请稍后再试"];
        return NO;
}
    return YES;

}

@end
