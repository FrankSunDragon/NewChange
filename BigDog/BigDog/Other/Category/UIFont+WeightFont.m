//
//  UIFont+WeightFont.m
//  FTAgreement
//
//  Created by sensu_nikun on 15/11/12.
//  Copyright © 2015年 SYF. All rights reserved.
//

#import "UIFont+WeightFont.h"

@implementation UIFont (WeightFont)

+(UIFont *)systemFontOfSize:(CGFloat)fontSize fontWeight:(SFUIDisplayWeight)weight{
    CGFloat fontweight =0.f;
    switch (weight) {
        case SFUIDisplay_Ultralight:
            fontweight = -0.8;
            break;
        case SFUIDisplay_Thin:
            fontweight = -0.6;break;
        case SFUIDisplay_Light:
            fontweight = -0.4;break;
        case SFUIDisplay_Regular:
            fontweight = 0.f;break;
        case SFUIDisplay_Medium:
            fontweight = 0.2;break;
        case SFUIDisplay_Semibold:
            fontweight = 0.3;break;
        case SFUIDisplay_Bold:
            fontweight = 0.5;break;
        case SFUIDisplay_Black:
            fontweight = 0.8;break;
            
        default:
            break;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue]<8.2) {
         UIFont * font =[UIFont systemFontOfSize:fontSize];
        return font;
    }
    UIFont * font =[UIFont systemFontOfSize:fontSize weight:fontweight];
    return font;
}

@end
