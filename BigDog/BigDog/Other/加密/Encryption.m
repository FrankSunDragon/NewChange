//
//  Encryption.m
//  DRHProduct
//
//  Created by 马博 on 16/3/2.
//  Copyright © 2016年 马博. All rights reserved.
//

#import "Encryption.h"

@implementation Encryption

+ (NSString *)Encryption_string:(NSString *)strin numscStr:(NSString *)numscStr
{
    
    //    加密值
    NSString *str = strin;
    //    进行base64加密
    NSString *strBase = [[str dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];
    
    //    获取随机数
    int numsc = [numscStr intValue];
    
    //    对应的表
    NSString *strnub = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 + /";
    
    //    对应表的数组
    NSArray *arrBase = [strnub componentsSeparatedByString:@" "];
    
    NSMutableArray *arrBase11 = [[NSMutableArray alloc] initWithArray:arrBase];
    NSMutableArray *arrBase111 = [[NSMutableArray alloc] initWithArray:arrBase];

    //    获取的数组
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < strBase.length; i++) {
        NSString *sub = [strBase substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:sub];
        
    }
    //    原数组移位
    NSString *temp;
    for (int i = numsc; i > 0; i--) {
        
        temp = [NSString stringWithFormat:@"%@",arrBase11.lastObject];
        [arrBase11 removeLastObject];
        [arrBase11 insertObject:temp atIndex:0];
        
    }
    //    获取了数组下边
    NSMutableArray *arrppp = [NSMutableArray array];
    for (NSString *str in arr) {
        
        if ([arrBase11 containsObject:str]) {
            
            [arrppp addObject:[arrBase111 objectAtIndex:[arrBase11 indexOfObject:str]]];
            
        }
    }
    
    NSString *basestr = [arrppp componentsJoinedByString:@""];
    
//    进行解密
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)basestr,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return outputStr;
    
}

+ (NSString *)POSREncryption_string:(NSString *)strin numscStr:(NSString *)numscStr{
    
    //    加密值
    NSString *str = strin;
    //    进行base64加密
    NSString *strBase = [[str dataUsingEncoding:NSUTF8StringEncoding]base64EncodedStringWithOptions:0];
    
    //    获取随机数
    int numsc = [numscStr intValue];
    
    //    对应的表
    NSString *strnub = @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9 + /";
    
    //    对应表的数组
    NSArray *arrBase = [strnub componentsSeparatedByString:@" "];
    
    NSMutableArray *arrBase11 = [[NSMutableArray alloc] initWithArray:arrBase];
    NSMutableArray *arrBase111 = [[NSMutableArray alloc] initWithArray:arrBase];
    
    //    获取的数组
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < strBase.length; i++) {
        NSString *sub = [strBase substringWithRange:NSMakeRange(i, 1)];
        [arr addObject:sub];
    }
    
    //    原数组移位
    NSString *temp;
    for (int i = numsc; i > 0; i--) {
        
        temp = [NSString stringWithFormat:@"%@",arrBase11.lastObject];
        [arrBase11 removeLastObject];
        [arrBase11 insertObject:temp atIndex:0];
        
    }
    //    获取了数组下边
    NSMutableArray *arrppp = [NSMutableArray array];
    for (NSString *str in arr) {
        
        if ([arrBase11 containsObject:str]) {
            
            [arrppp addObject:[arrBase111 objectAtIndex:[arrBase11 indexOfObject:str]]];
            
        }
    }
    
    NSString *basestr = [arrppp componentsJoinedByString:@""];
    

    return basestr;
    
}


@end
