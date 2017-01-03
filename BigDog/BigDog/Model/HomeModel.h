//
//  HomeModel.h
//  BigDog
//
//  Created by Jacky Sun on 2016/11/1.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "FDClass.h"

@interface HomeModel : FDClass

@property (copy, nonatomic) NSString  * area;


@property (assign, nonatomic) NSUInteger uid;



/**
 *  保存全局用户配置信息
 *
 */
+ (BOOL)saveTxtConvertModelForDict:(NSArray *)modelArr;


+(void)saveJsonStr:(NSString *)str;


/**
 *  取出缓存在沙河里的东西
 *
 *  @return return value description
 */
+ (NSArray *)bd_getModelArrWithCheck:(BOOL)ISCheck;


//上传时获取用户用pwd加密的数据(json字符串)
+ (NSString *)getUserNotAesData;


//如果用户用错误的密码，删除沙河里面的文件
- (void)deleteUserFile;
@end
