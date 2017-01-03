//
//  GlobalVariables.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/2.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables


+ (GlobalVariables *)shareGlobalVariables{
    static GlobalVariables * bb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bb = [[GlobalVariables alloc] init];
    });
    return bb;
}

@end
