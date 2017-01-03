//
//  GlobalVariables.h
//  BigDog
//
//  Created by Jacky Sun on 2016/11/2.
//  Copyright © 2016年 syf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface GlobalVariables : NSObject

//@property (strong, nonatomic) UserInfo * currentInfo;


@property (copy, nonatomic) NSString  *  username;


@property (copy, nonatomic) NSString  * pwd;




+ (GlobalVariables *)shareGlobalVariables;

@end
