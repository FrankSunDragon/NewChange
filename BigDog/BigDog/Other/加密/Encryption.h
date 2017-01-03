//
//  Encryption.h
//  DRHProduct
//
//  Created by 马博 on 16/3/2.
//  Copyright © 2016年 马博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encryption : NSObject

+ (NSString *)Encryption_string:(NSString *)strin numscStr:(NSString *)numscStr;

//- (NSString*)UrlValue_Encode:(NSString*)dString;

//post 调用
+ (NSString *)POSREncryption_string:(NSString *)strin numscStr:(NSString *)numscStr;


@end
