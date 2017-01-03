//
//  SYFCustomCLASS.h
//  APPDemo
//
//  Created by apple on 15-3-9.
//  Copyright (c) 2015年 SenYu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SYFCustomCLASS : NSObject
/**
 *  1、色值转换（CSS ---RGB）
 */
+(UIColor *)SYFColorChange: (NSString *) stringToConvert;

/**
 *  2、中心拉伸图片
 */
+ (UIImage *)SYFResizeImage:(NSString *)name;


/**
 *  3、Webview 的自适应宽度 加载HTML
 */
+ (NSString *)stringCreateHTMLData: (NSString *)BAK;
+ (NSString *)stringCreateJavaScript;


/**
 *  4.字符串 为空(nil)的验证
*/
+ (BOOL)SYFIsEmptyOrNull:(NSString *)string;


/**
 *  5、计算 label 文字的尺寸
 */
+ (CGSize)SYFSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;


/**
 *  6、处理金钱字符串（加逗号）
 */
+(NSString *)SYFCountNumAndChangeformat:(NSString *)num;

/**
 *  7、判断设备是否联网
 */
+ (BOOL)xianshiTIXing: (UIViewController *)VC;


/**
 *  8、处理日期（2015-12-1 12月01日）
 */
+(NSString *)SYFDealWithDateFormat:(NSString *)DateStr;


/// 9. 输入日期字符串，计算当天是周几
+ (NSString *)SYFWeekDayWithDate:(NSString *)date;


///10、 判断应用是否允许定位
+(BOOL)SYFlocationServicesEnabled;


///11、 webview 替换HTML里面图片的宽高 截取第一个参数和第二个参数之间的字段
+(NSString  * )SYFWithAndHeight:(NSString *)str1 paratemer:(NSString *)str2 WithHtml:(NSString *)html;


/**
 *  12、  点赞动画
 */
+(void)SYFLikeAnimation:(UIView *)sender;


/**
 *  13、处理时间的方法
 */
+ (NSString *)SYFCustomTime:(NSString *)sevriceTime;


///14 自己写的， 针对于， 用户中心，更换的icon
+ (UIImage *) SYFUSerIconImageCrop:(UIImage *)sourceImage;

/**
 *  15、给uilabel 添加行间距之后的适配
 */
+ (CGSize)SYF_adaptLineSpacingWithLabel:(UILabel *)lab withSpacing:(CGFloat)spacing withMaxsize:(CGSize)zise withText:(NSString *)str;

/**
 *  16、计算文本的高度
 *
 */
+ (CGSize)SYF_adaptLineSpacingWithLabel:(CGFloat)spacing withMaxsize:(CGSize)zise withText:(NSString *)str withFont:(UIFont *)font withNumberOfLines:(CGFloat)lines;

/**
 *  17、计算一个时间和现在时间的差值（秒数）
 */
+(NSInteger)syf_timeDifferentenceFromTime:(NSString *)timeStr;


+ (BOOL)SYF_checkNum:(NSString *)str;

/**
 *  检测是不是整数
 *
 */
+ (BOOL)SYF_checkNum_1:(NSString *)str;


@end
