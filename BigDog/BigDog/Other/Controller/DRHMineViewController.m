//
//  DRHMineViewController.m
//  DRHProduct
//
//  Created by Jacky Sun on 16/3/24.
//  Copyright © 2016年 马博. All rights reserved.
//
#define headerHeight 178.0

#define UserIconWH  95.0

#define NavIconWH  30.0

#define statusH 20

#import "DRHMineViewController.h"

#import "CExpandHeader.h"


@interface DRHMineViewController ()<UIScrollViewDelegate>
{
    __weak IBOutlet UIView *_headView;
    CExpandHeader *_header;// 表头
    
    UIImageView * _titleIMg;// 默认头像
    
    UIButton * _headBtn; // 处理事件的btn
    
     UIScrollView *backScrollview;
}
@end

@implementation DRHMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUPTaleHeardView];
    
    [self setUpNavtitleVIew];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

/**
 *  设置表头
 */
- (void)setUPTaleHeardView
{
    backScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    [self.view addSubview:backScrollview];
     backScrollview.showsVerticalScrollIndicator = NO;
    backScrollview.delegate = self;
    backScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT*1.1);
    
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerHeight)];
    customView.backgroundColor = DRHColor(233, 73, 71);
 
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headBtn = btn;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(lookUpUserDetail) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:btn];
    
    UILabel * userNameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, customView.height-12-15, SCREEN_WIDTH, 15)];// 15 为自身高度  12  是距负空间距离
    userNameLab.text = @"Jacky Sun";
    userNameLab.textAlignment = NSTextAlignmentCenter;
    userNameLab.textColor = [UIColor whiteColor];
    userNameLab.font = [UIFont systemFontOfSize:15 fontWeight:SFUIDisplay_Light];
    [customView addSubview:userNameLab];
    userNameLab.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    _header = [CExpandHeader expandWithScrollView:backScrollview expandView:customView];
    
}

// 查看用户资料详情
- (void)lookUpUserDetail{
    NSLog(@"点击我惦记我");
}

// 设置导航栏的titleview
-(void)setUpNavtitleVIew{
    UIImageView * img = [[UIImageView alloc] init];
    img.center = CGPointMake(SCREEN_WIDTH/2.0, 50+UserIconWH*0.5);
    img.bounds = CGRectMake(0, 0, UserIconWH , UserIconWH);
   
    img.image = [UIImage imageNamed:@"icon_weirenzheng"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.layer.borderColor = [UIColor whiteColor].CGColor;
    img.layer.borderWidth = 1.2;
    img.layer.cornerRadius = UserIconWH/2.0;
    img.layer.masksToBounds = YES;
    _titleIMg = img;
    [_headView addSubview:img];
    
    img.userInteractionEnabled = YES;
    
    [img addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookUpUserDetail)]];
    
    
    _headBtn.bounds = img.bounds;
    _headBtn.center  =  img.center;
    
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetY = scrollView.contentOffset.y+headerHeight - 64;
    NSLog(@"偏移量：：：：：%f",offsetY);
    //offsetY = (offsetY<=0)  ? offsetY-64 : offsetY;
    
    if(offsetY == 0 || offsetY == -64) return;
    
    //  随着scrollview 的滚动， 改变bounds
    CGRect bound = _titleIMg.bounds;
    CGFloat yuanw =  MAX(NavIconWH, UserIconWH - (offsetY + 64) *(UserIconWH - NavIconWH)/(headerHeight - 64) ) ;
    _titleIMg.layer.cornerRadius = yuanw/2.0;
    bound.size.height = yuanw;
    bound.size.width  = yuanw;
    
    _titleIMg.bounds = bound;
 
    // 改变center  55.5 是滚动 center y值 最大的偏差
    CGPoint center = _titleIMg.center;
    CGFloat yuany =  MAX(42, UserIconWH - (offsetY + 64) *55.5/(headerHeight - 64) ) ;
    
  //  NSLog(@"y值到底是几%f",yuany);
    center.y = yuany;
    _titleIMg.center = center;
    
    _headBtn.bounds = _titleIMg.bounds;
    
   // CGFloat  sdfsd   = (yuany<=64) ? 60 :20;
    
    _headBtn.center = _titleIMg.center;
    //_headBtn.center  =   _titleIMg.center;
    //[_titleIMg convertPoint:_titleIMg.center fromView:self.view];
   // NSLog(@"%@",NSStringFromCGPoint(_headBtn.center));
    
}







@end
