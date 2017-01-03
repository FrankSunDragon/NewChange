//
//  SYFCustomVIEW.h
//  APPDemo
//
//  Created by apple on 15-3-9.
//  Copyright (c) 2015年 SenYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYFCustomVIEW : UIView
/**
 *  1/返回一个 自定义 的label(不管文字位置)
 */
+ (UILabel *)SYFNEWLabel: (NSString * )text withFont: (CGFloat)font withTextColor: (UIColor *)color;

/**
 *  2、返回 自定义label （有文字位置）
 *
 */
+ (UILabel *)SYFNEWLabel_2: (NSString * )text withFont: (CGFloat)font withTextColor: (UIColor *)color withAlignment: (NSTextAlignment )align;


/**
 *  3、返回一个 自定义 的button
 */
+ (UIButton *)SYFNEWButton: (NSString *)text withTextFont: (CGFloat)font withTextColor: (UIColor *)color withBackGroundImage: (UIImage *)backImage withImage: (UIImage *)image;




/**
 * 4、 返回一个 UIBarButtonItem
 */
+ (UIButton *)SYFNEWBarButton: (NSString *)imageStr WithISLeft:(BOOL)isPianyi;


/**
 *  5、返回 根据文字长度而计算label size(MAXFLOAT)
 */
+(UILabel *)SYFNEWLabelByTextLength:(NSString *)text withTextFont: (CGFloat)font withLabelMaxSize: (CGSize)maxSize withTextColor:(UIColor *)color withLabY:(CGFloat)Y;


/**
 *  6、快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;


/**
 * 7、返回 一个 textfield
 */
+ (UITextField *)SYFTextfield:(UIColor *)textColor  WithPlaceholder: (NSString *)placeText isHaveLeftImgView: (BOOL)ISImg withTextFont: (CGFloat)font withLeftImg: (UIImage *)leftImg;


/**
 *  8、返回一条下滑线
 */
+(UIView *)SYFLineView:(CGFloat)LineY lineColor:(UIColor *)color lineHieght:(CGFloat)Height;


/// 9、 返回一个警告框 弹出框，带一个“确定”按钮
+(void)SYFAlertMessage:(NSString *)message;


/// 10、 加载一张图片
+ (UIImage * )SYFIMgWithResoursePath:(NSString *)pathName;

@end
