//
//  HomeModel.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/1.
//  Copyright © 2016年 syf. All rights reserved.
//

#define DOGPATH  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]


#import "HomeModel.h"
#import "DRHProgressHUD.h"
@implementation HomeModel

///把模型数组转换为然后保存为txt起来
+ (BOOL)saveTxtConvertModelForDict:(NSArray *)modelArr{
    
    //1、 把模型数组转换为字典数组
    NSMutableArray * dictArr = [NSMutableArray array];
    for(HomeModel * model in modelArr){
        NSDictionary * dict = model.mj_keyValues;
        [dictArr addObject:dict];
            }
    //2、 把字典数组转为data
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictArr options:NSJSONWritingPrettyPrinted error:nil];
    //Json字符串
    NSString *dataStr = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    
    //3、对data进行aes加密
    NSString * aesStr = [SecurityUtil encryptAESData:dataStr secretKey:[GlobalVariables shareGlobalVariables].pwd];
    
    return  [aesStr writeToFile:[self filePath] atomically:YES];
}

+(void)saveJsonStr:(NSString *)str{
    // 不用进行加密
    // 返回的数据就是pwd过的密文
   // NSString * aesStr = [SecurityUtil encryptAESData:str secretKey:[GlobalVariables shareGlobalVariables].pwd];
    [str writeToFile:[self filePath] atomically:YES];

}

// 取出 模型数组
+ (NSArray *)bd_getModelArrWithCheck:(BOOL)ISCheck
{
   
    NSString * aesStr = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
    if(aesStr == nil){
        if(ISCheck)
        [DRHProgressHUD FDShowClock:@"本地没有缓存此用户数据"];
        return nil;
    }
    //1、 把加密后的字符串进行解密，解密后是json字符串
    NSString * str = [SecurityUtil decryptAESData:aesStr secretKey:[GlobalVariables shareGlobalVariables].pwd];
    
    if(str == nil){
        if(ISCheck)
        [DRHProgressHUD FDShowClock:@"解密数据失败,请更新数据"];
        return nil;
    }
    
    NSData * data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSArray * dictArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return  [HomeModel mj_objectArrayWithKeyValuesArray:dictArr];
}


+ (NSString *)getUserNotAesData{
    NSString * aesStr = [NSString stringWithContentsOfFile:[self filePath] encoding:NSUTF8StringEncoding error:nil];
    if(aesStr == nil){
        [DRHProgressHUD FDShowClock:@"本地没有缓存此用户数据"];
        return nil;
    }
    //1、 把加密后的字符串进行解密，解密后是json字符串
   // NSString * str = [SecurityUtil decryptAESData:aesStr secretKey:[GlobalVariables shareGlobalVariables].pwd];
    
//    if(str == nil){
//        [DRHProgressHUD FDShowClock:@"解密数据失败,用户密码错误"];
//        return nil;
//    }
    return aesStr;
}




+ (NSString *)filePath{
    NSString * fileName = [NSString stringWithFormat:@"%@.txt",[GlobalVariables shareGlobalVariables].username];
    NSString * path = [DOGPATH stringByAppendingPathComponent:fileName];
    return path;
}
@end
