//
//  DRHFeedbackViewController.h
//  DRHProduct
//
//  Created by Jacky Sun on 16/4/26.
//  Copyright © 2016年 马博. All rights reserved.
//

#import "FDBaseViewController.h"
#import "HomeModel.h"

@interface DRHFeedbackViewController : FDBaseViewController


@property (strong, nonatomic) HomeModel * model;

///是不是新增的备忘录
@property (assign, nonatomic) BOOL ISNewText;
@end
