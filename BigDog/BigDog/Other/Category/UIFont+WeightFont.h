//
//  UIFont+WeightFont.h
//  FTAgreement
//
//  Created by sensu_nikun on 15/11/12.
//  Copyright © 2015年 SYF. All rights reserved.
//

#import <UIKit/UIKit.h>

//苹方字体
typedef NS_ENUM(NSInteger,SFUIDisplayWeight) {
    //
    SFUIDisplay_Ultralight = -3,
    //
    SFUIDisplay_Thin,
    //
    SFUIDisplay_Light,
    /// 常规
    SFUIDisplay_Regular =0,
    
    SFUIDisplay_Medium,
    //半粗
    SFUIDisplay_Semibold,
    
    SFUIDisplay_Bold,
    
    SFUIDisplay_Black
    
};

@interface UIFont (WeightFont)

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize fontWeight:(SFUIDisplayWeight)weight;


@end
