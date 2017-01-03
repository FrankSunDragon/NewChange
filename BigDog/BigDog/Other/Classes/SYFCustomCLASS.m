//
//  SYFCustomCLASS.m
//  APPDemo
//
//  Created by apple on 15-3-9.
//  Copyright (c) 2015年 SenYu. All rights reserved.
//

#import "SYFCustomCLASS.h"
#import "Reachability.h"
#import "NSDate+MJ.h"


@implementation SYFCustomCLASS
/**
 *  色值转换（CSS ---RGB）
 */
+(UIColor *)SYFColorChange: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if (r==255&&g==255&&b==255)
    {
        return  [UIColor whiteColor];
    }
    else
    {
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }

  }


+ (UIImage *)SYFResizeImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}


+ (NSString *)stringCreateHTMLData: (NSString *)BAK
{
    ////
    NSString * js = @"<script language='Javascript'> "
    "function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth=300;" //缩放系数
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    //"alert('Old'+myimg.width+'  '+myimg.height);"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = maxwidth;"
    //"alert('New'+myimg.width+'  '+(myimg.height*maxwidth/oldwidth)+' '+myimg.height+'  '+maxwidth+'  '+oldwidth);"
    //"myimg.height = myimg.height*(maxwidth/oldwidth);"
    //"alert('New2 '+myimg.width+'  '+myimg.height+' '+maxwidth);"
    "}"
    "}"
    "} "
    "window.onload = function(){ResizeImages();};"
    "</script>";
    
    NSString * HTMLData =  [NSString stringWithFormat:@"<!DOCTYPE html><html lang='zh-cn'><head><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'>  </head><body role='document'> %@ %@</body></html>",BAK,js];
    
    
    return HTMLData;
    
}


+ (NSString *)stringCreateJavaScript
{
//    return @"var tagHead =document.documentElement.firstChild;"
//    "var tagStyle = document.createElement(\"style\");"
//    "tagStyle.setAttribute(\"type\", \"text/css\");"
//    "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 20pt 15pt}\"));"
//    "var tagHeadAdd = tagHead.appendChild(tagStyle);";
    return @"var script =document.createElement('script');"
    
    "script.type = 'text/javascript';"
    
    "script.text = \"function ResizeImages(){ "
    
    "var myimg,oldwidth,oldheight;"
    
    "var maxwidth=320;"// 图片宽度
    
    "for(i=0;i<document.images.length;i++){"
    
    "myimg = document.images[i];"
    
    "if(myimg.width > maxwidth){"
    
    "myimg.width = maxwidth;"
    
    "}"
    
    "}"
    
    "}\";"
    
    "document.getElementsByTagName('head')[0].appendChild(script);";
}


+ (BOOL)SYFIsEmptyOrNull:(NSString *)string{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    
//    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
//        return YES;
//    }
    return NO;
}


#pragma mark  计算文字尺寸
+ (CGSize)SYFSizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


+(NSString *)SYFCountNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}


+ (BOOL)xianshiTIXing: (UIViewController *)VC
{
    if([Reachability isMayUseInternet]) {
        
        CGFloat JZScreenH = [UIScreen mainScreen].bounds.size.height;
        CGFloat JZScreenW = [UIScreen mainScreen].bounds.size.width;
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, JZScreenH/2-15,  JZScreenW-20, 40)];
        lab.text = @"当前网络不可用，请检查你的网络设置";
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 10.0;
        lab.adjustsFontSizeToFitWidth = YES;
        lab.alpha = 0.0;
        lab.backgroundColor = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1.0];
        [VC.view addSubview:lab];
        [UIView animateWithDuration:2.0 animations:^{
            lab.alpha = 1.0;
        } completion:^(BOOL finished) {
            lab.alpha = 0.0;
            [lab removeFromSuperview];
        }];
        
        return YES;
        
    }
    else
        return NO;
}

+(NSString *)SYFDealWithDateFormat:(NSString *)DateStr
{
    NSRange  range_1 = NSMakeRange(5, 2);
    NSString * Date_1 = [DateStr substringWithRange:range_1];
    
    NSRange  range_2 = NSMakeRange(8, 2);
    NSString * Date_2 = [DateStr substringWithRange:range_2];
    
    
    return [NSString stringWithFormat:@"%@月%@",Date_1,Date_2];
    
}

// 输入年月日 算周几
+ (NSString *)SYFWeekDayWithDate:(NSString *)date
{
    NSRange  range_0 = NSMakeRange(0, 4);
    NSString * Date_0 = [date substringWithRange:range_0];
    
    NSRange  range_1 = NSMakeRange(5, 2);
    NSString * Date_1 = [date substringWithRange:range_1];
    
    NSRange  range_2 = NSMakeRange(8, 2);
    NSString * Date_2 = [date substringWithRange:range_2];
    
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:[Date_2 integerValue]];
    [_comps setMonth:[Date_1 integerValue]];
    [_comps setYear:[Date_0 integerValue]];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
    if(_weekday == 1)
        return @"周日";
    else if (_weekday == 2)
        return @"周一";
    else if (_weekday == 3)
        return @"周二";
    else if (_weekday == 4)
        return @"周三";
    else if (_weekday == 5)
        return @"周四";
    else if (_weekday == 6)
        return @"周五";
    else if (_weekday == 7)
        return @"周六";
    return nil;
}



+(BOOL)SYFlocationServicesEnabled{
    BOOL isAv=NO;
//    NSLog(@"%d,%d",[CLLocationManager locationServicesEnabled],[CLLocationManager authorizationStatus]);
    //NSLog(@"%d",kCLAuthorizationStatusAuthorized);
    int status=[CLLocationManager authorizationStatus];
    
    BOOL bool1 =[CLLocationManager locationServicesEnabled];
    if (bool1 && (status >= 3)){
        isAv=YES;
    }
    return isAv;
    
}


+(NSString  * )SYFWithAndHeight:(NSString *)str1 paratemer:(NSString *)str2 WithHtml:(NSString *)html
{
    NSRange rang1=[html rangeOfString:str1];
    NSMutableString *imageStr2=[[NSMutableString alloc]initWithString:[html substringFromIndex:rang1.location+rang1.length]];

    NSRange rang2=[imageStr2 rangeOfString:str2];
    NSMutableString *imageStr3=[[NSMutableString alloc]initWithString:[imageStr2 substringToIndex:rang2.location]];
    return imageStr3 ;
}

+(void)SYFLikeAnimation:(UIView *)sender
{
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.8),@(1.2),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.6),@(1.2),@(1.6)];
    k.calculationMode = kCAAnimationLinear;
    [sender.layer addAnimation:k forKey:@"SHOW"];

}

+ (NSString *)SYFCustomTime:(NSString *)sevriceTime
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
   fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate * createdDate = [fmt dateFromString:sevriceTime];
    
    // 2..判断发送时间 和 现在时间 的差距
    if ([NSDate isToday:createdDate]) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", (int)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", (int)createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
        
    }
    else if([NSDate isThisMonth:createdDate]){
        int days =  (int)createdDate.deltaWithNow.day +1;
        return [NSString stringWithFormat:@"%d天前", days];
    }
    else
    {
        NSString * str1 = [sevriceTime substringWithRange:NSMakeRange(5,2)];
        NSString * str2 = [sevriceTime substringWithRange:NSMakeRange(8,2)];
        NSString * str = [NSString stringWithFormat:@"%@月%@日",str1,str2];
        return str;
    }
    
    //else if (createdDate.isYesterday) { // 昨天
    //        fmt.dateFormat = @"昨天 HH:mm";
    //
    //        return [fmt stringFromDate:createdDate];
    //    } else if (createdDate.isThisYear) { // 今年(至少是前天)
    //        fmt.dateFormat = @"MM-dd HH:mm";
    //        return [fmt stringFromDate:createdDate];
    //    } else { // 非今年
    //        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    //        return [fmt stringFromDate:createdDate];
    //    }
    
}


+ (UIImage *) SYFUSerIconImageCrop:(UIImage *)sourceImage
{
    CGFloat ViewWidth=  [UIScreen mainScreen].bounds.size.width;

    
    UIImage * newImage  = sourceImage;
    
    // 1、  压缩图片  （不对，应该将压缩图片放在第一步）
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.5);
    newImage = [UIImage imageWithData:imageData];
    
    
    // 2、 想将图片 处理成 符合要求的图片 要么长 要么宽
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if(width == ViewWidth)
    {
        
    }
    else{
        height =  ViewWidth*height/width;
        width = ViewWidth;
        
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [sourceImage drawInRect:CGRectMake(0,0,width,  height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    //3. 第三部 的处理  如果长大于宽
    if(width>height){
        
        CGImageRef imageRef = newImage.CGImage;
        CGRect frame = CGRectMake((width-height)/2.0, 0,height , height);
        CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, frame);
        newImage  = [UIImage imageWithCGImage:imagePartRef];
        CGImageRelease(imagePartRef);
    }
    
    return newImage;
}


+ (CGSize)SYF_adaptLineSpacingWithLabel:(UILabel *)lab withSpacing:(CGFloat)spacing withMaxsize:(CGSize)zise withText:(NSString *)str
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    lab.attributedText = attributedString;
    CGSize labelSize = [lab sizeThatFits:zise];
    return labelSize;
}


+ (CGSize)SYF_adaptLineSpacingWithLabel:(CGFloat)spacing withMaxsize:(CGSize)zise withText:(NSString *)str withFont:(UIFont *)font withNumberOfLines:(CGFloat)lines
{
    UILabel * lab = [[UILabel alloc] init];
    lab.font = font;
    lab.numberOfLines = lines;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    lab.attributedText = attributedString;
    CGSize labelSize = [lab sizeThatFits:zise];
    lab = nil;
    return labelSize;
}


+ (NSInteger)syf_timeDifferentenceFromTime:(NSString *)timeStr{
    
    NSDate * NowDate  = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    //fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 微博的创建日期
    NSDate *endDate = [fmt dateFromString:timeStr];
    NSTimeInterval aTimer = [endDate timeIntervalSinceDate:NowDate];
    return  (NSInteger)aTimer ;
}


+ (BOOL)SYF_checkNum:(NSString *)str
{
    NSString *regex = @"^[0-9]+(.[0-9]{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

/**
 *  检测是不是整数
 *
 */
+ (BOOL)SYF_checkNum_1:(NSString *)str
{
    NSString * regex = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}


@end
