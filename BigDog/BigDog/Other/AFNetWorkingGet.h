//
//  AFNetWorkingGet.h
//  Dronghui
//
//  Created by 马博 on 16/1/6.
//  Copyright © 2016年 dongronghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface AFNetWorkingGet : NSObject


+ (void)GET_RequestWithAlertView:(NSString *)url params:(NSDictionary *)params isHUD:(BOOL)isNeedHUD isAlert:(BOOL)isAlert completion:(void (^)(id))success failure:(void (^)(NSError *))failure connect:(void (^)(BOOL))IsAvailable;


// 4、普通的post请求
+ (void)DRH_general_post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable;

/**
 *  5、图片上传
 */
+ (void)DRH_loadImg_post:(NSString *)url image:(UIImage *)image success:(void (^)(id json))success failure:(void (^)(NSError *error))failure connect:(void(^)(BOOL internet))IsAvailable;


/**
 *  6、返回当前网络状况
 *
 *  @return yes 代表有网，no代表无网
 */
+ (BOOL)DRH_currentNetworkStatus;
@end
