//
//  RansomTFd.m
//  DRHProduct
//
//  Created by Jacky Sun on 16/4/13.
//  Copyright © 2016年 马博. All rights reserved.
//

#import "RansomTFd.h"
#import "SYFCustomCLASS.h"

@implementation RansomTFd
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UILabel * lab = [[UILabel alloc] init];
        lab.text = self.leftLabText;
        // lab.backgroundColor = [UIColor cyanColor];
        lab.font = [UIFont systemFontOfSize:16 fontWeight:SFUIDisplay_Regular];
        lab.textColor = [SYFCustomCLASS SYFColorChange:@"#66666"];
        self.leftView = lab;
        self.leftView.frame = CGRectMake(15, 0, 100, 50);
        self.leftViewMode = UITextFieldViewModeAlways;
        
        
        //字体
        self.font = [UIFont systemFontOfSize:16 fontWeight:SFUIDisplay_Regular];
        // self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 键盘右下角 的样式
        // textFD.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
        // textFD.borderStyle =  UITextBorderStyleRoundedRect;
        
        NSMutableDictionary * dict = [NSMutableDictionary dictionary];
        dict[NSForegroundColorAttributeName] =  [SYFCustomCLASS SYFColorChange:@"#a3a3a3"] ;
        if(self.placeholder == nil)
            self.placeholder = @" ";
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
        
        
    }
    return self;
}

- (void)setLeftLabText:(NSString *)leftLabText{
    _leftLabText = leftLabText;
    UILabel * lab = (UILabel *)self.leftView;
    lab.text = _leftLabText;
}

//- (void)setPlaceholder:(NSString *)placeholder{
//    [super setPlaceholder:placeholder];
//    // 设置提醒文字
//    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
//    dict[NSForegroundColorAttributeName] =  [SYFCustomCLASS SYFColorChange:@"#a3a3a3"] ;
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:dict];
//}



-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController * menu = [UIMenuController sharedMenuController];
    if (menu) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
