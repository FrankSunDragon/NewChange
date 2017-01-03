//
//  SYFCustomVIEW.m
//  APPDemo
//  Created by apple on 15-3-9.
//  Copyright (c) 2015年 SenYu. All rights reserved.
//

#import "SYFCustomVIEW.h"
#import "SYFCustomCLASS.h"


@implementation SYFCustomVIEW


+ (UILabel *)SYFNEWLabel: (NSString * )text withFont: (CGFloat)font withTextColor: (UIColor *)color
{
    UILabel * postTitleLab =[[UILabel alloc] init];
    postTitleLab.text = text;
    postTitleLab.font = [UIFont systemFontOfSize:font];
    postTitleLab.textColor = color;
    return postTitleLab;
    
}


+ (UILabel *)SYFNEWLabel_2: (NSString * )text withFont: (CGFloat)font withTextColor: (UIColor *)color withAlignment: (NSTextAlignment )align
{
    UILabel * postTitleLab =[[UILabel alloc] init];
    postTitleLab.text = text;
    postTitleLab.font = [UIFont systemFontOfSize:font];
    postTitleLab.textColor = color;
    postTitleLab.textAlignment = align;
    return postTitleLab;
    
}

+ (UIButton *)SYFNEWBarButton: (NSString *)imageStr WithISLeft:(BOOL)isPianyi 
{
    UIButton *  navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    navLeftButton.frame = CGRectMake(0, 0, 44, 44);
    [navLeftButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    navLeftButton.imageEdgeInsets = UIEdgeInsetsMake(-11.5, 0, -11.5, -23);
    return navLeftButton;
}


+ (UIButton *)SYFNEWButton: (NSString *)text withTextFont: (CGFloat)font withTextColor: (UIColor *)color withBackGroundImage: (UIImage *)backImage withImage: (UIImage *)image
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:backImage forState:UIControlStateHighlighted];
       [btn setImage:image forState:UIControlStateNormal];
    btn.layer.cornerRadius = 3;
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    return btn;
}




#pragma mark  计算文字尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

//+(UILabel *)SYFNEWLabelByTextLength:(NSString *)text withTextFont: (CGFloat)font withLabelMaxSize: (CGSize)maxSize withReturnSize: (void (^)(CGSize *))realSize
//{
//    UILabel * postTitleLab =[[UILabel alloc] init];
//    postTitleLab.text = text;
//    postTitleLab.font = [UIFont systemFontOfSize:font];
//    CGSize  size1 = [SYFCustomVIEW sizeWithText:text font:[UIFont systemFontOfSize:font] maxSize:maxSize];
//  
//    realSize(size1);
//    return postTitleLab;
//}
+(UILabel *)SYFNEWLabelByTextLength:(NSString *)text withTextFont: (CGFloat)font withLabelMaxSize: (CGSize)maxSize withTextColor:(UIColor *)color withLabY:(CGFloat)Y{
    
    UILabel * lab = [SYFCustomVIEW SYFNEWLabel:text withFont:font withTextColor:color];
    lab.numberOfLines = 0;
    CGSize  realSize = [self sizeWithText:text font:[UIFont systemFontOfSize:font] maxSize:maxSize];
    lab.frame = CGRectMake((SCREEN_WIDTH -maxSize.width), Y, realSize.width, realSize.height);
    return lab;
    
}



+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}



+ (UITextField *)SYFTextfield:(UIColor *)textColor  WithPlaceholder: (NSString *)placeText isHaveLeftImgView: (BOOL)ISImg withTextFont: (CGFloat)font withLeftImg: (UIImage *)leftImg
{
    UITextField * textFD = [[UITextField alloc] init];
    UIImageView * img = [[UIImageView alloc] init];
    img.image = leftImg;
    
    img.contentMode = UIViewContentModeScaleAspectFit;
    textFD.leftView = img;
   // CGFloat padding = SYFHeight == 480?40:50;
    textFD.leftView.frame = CGRectMake(11, 11, 32, 21);
    textFD.leftViewMode = UITextFieldViewModeAlways;
    //字体
    textFD.font = [UIFont systemFontOfSize:font];
    textFD.clearButtonMode = UITextFieldViewModeAlways;
    
    // 键盘右下角 的样式
    // textFD.returnKeyType = UIReturnKeySearch;
    textFD.enablesReturnKeyAutomatically = YES;
    // textFD.borderStyle =  UITextBorderStyleRoundedRect;
    
    // 设置提醒文字
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] =   DRHColor(203, 203, 209);
    textFD.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeText attributes:dict];
        
    textFD.textColor = textColor;
    return textFD;
}

+(UIView *)SYFLineView:(CGFloat)LineY lineColor:(UIColor *)color lineHieght:(CGFloat)Height
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, LineY, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = color;
    return view;
}

+(void)SYFAlertMessage:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

+ (UIImage * )SYFIMgWithResoursePath:(NSString *)pathName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:pathName ofType:@"png"];
    return  [UIImage imageWithContentsOfFile:path];
}

@end
