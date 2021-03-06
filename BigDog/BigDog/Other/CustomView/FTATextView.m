//
//  FTATextView.m
//  FTAgreement
//
//  Created by syf on 15/11/17.
//  Copyright © 2015年 SYF. All rights reserved.
//

#import "FTATextView.h"
@interface FTATextView()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FTATextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
          }
    return self;
}

- (void)createSubview
{
    self.showsVerticalScrollIndicator = NO;
    
    // 1.添加提示文字
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    placeholderLabel.hidden = YES;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.font = self.font;
    [self insertSubview:placeholderLabel atIndex:0];
    self.placeholderLabel = placeholderLabel;
    
    // 2.监听textView文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;

    if (placeholder.length) { // 需要显示
        self.placeholderLabel.hidden = NO;
        
        // 计算frame
        CGFloat placeholderX = 5;
        CGFloat placeholderY = 7;
        CGFloat maxW = SCREEN_WIDTH - 3 * placeholderX;
        CGFloat maxH = SCREEN_HEIGHT - 2 * placeholderY;
        CGSize placeholderSize = [self.placeholderLabel sizeThatFits:CGSizeMake(maxW, maxH)];
        //[placeholder sizeWithFont:self.placeholderLabel.font constrainedToSize:CGSizeMake(maxW, maxH)];
        self.placeholderLabel.frame = CGRectMake(placeholderX, placeholderY, placeholderSize.width, placeholderSize.height);
    } else {
        self.placeholderLabel.hidden = YES;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    self.placeholder = self.placeholder;
}

-  (void)setText:(NSString *)text{
    [super setText:text];
    [self textDidChange];
}

- (void)textDidChange
{
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
