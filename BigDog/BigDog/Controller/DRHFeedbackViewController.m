//
//  DRHFeedbackViewController.m
//  DRHProduct
//
//  Created by Jacky Sun on 16/4/26.
//  Copyright © 2016年 马博. All rights reserved.
//

#import "DRHFeedbackViewController.h"
#import "FTATextView.h"
@interface DRHFeedbackViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate, UIAlertViewDelegate>
{
    __weak IBOutlet UIScrollView *backScroll;
    IBOutlet UIView *_containerVIew;
    
    __weak IBOutlet FTATextView *textView;
    
    
    
}
@end

@implementation DRHFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationbar];
    
    if(!_ISNewText)
     textView.text = _model.area;
}

- (void)BackBtnClick
{
    
    void (^ myBlock)(NSUInteger index) = ^(NSUInteger index){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否保存本次更新？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
        alert.tag = index;
        [alert show];
    };
    
    
    if([_model.area isEqualToString:textView.text] ||(_ISNewText && textView.text.length == 0)){
        [self.navigationController popViewControllerAnimated:YES];

    }
    else if (_ISNewText && textView.text.length>0){
        myBlock(11);// 新增备忘录


    }
    else{
        myBlock(12);// 修改备忘录
    }
    
   }

- (void)setUpNavigationbar{
    NSString * title = _ISNewText ? @"新增备忘录" : @"文本详情";
    [self FD_NavigationBarWithTitle:title];
    _containerVIew.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    [backScroll addSubview:_containerVIew];
    
    textView.placeholder = @"欢迎使用Big Dog移动电子备忘录……";
    textView.font = [UIFont systemFontOfSize:15 fontWeight:SFUIDisplay_Light];
    //textView.textColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    textView.spellCheckingType = UITextSpellCheckingTypeNo;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
   
    backScroll.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-63);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存本地" style:UIBarButtonItemStylePlain target:self action:@selector(commitUserOperation)];
    
 }




-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1)// 保存更新后的文本
       [self commitUserOperation];
    else
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitUserOperation{
    
    __weak DRHFeedbackViewController * blockSelf = self;
    void (^myBlock)(NSArray * arr) = ^(NSArray * arr){
        
        if([HomeModel saveTxtConvertModelForDict:arr]){
            [DRHProgressHUD FDShowClock:@"保存到本地TXT成功"];
            [blockSelf.navigationController popViewControllerAnimated:YES];
            
        }
        else{
            [DRHProgressHUD FDShowClock:@"保存到本地TXT失败"];
        }
  
    };
    
    
    if(!_ISNewText){// 修改备忘录
        NSArray * modelArr = [HomeModel bd_getModelArrWithCheck:NO];
        for(HomeModel * model in  modelArr){
            if(model.uid == _model.uid){
                model.area = textView.text;
            }
        }
        myBlock(modelArr);
        
    }
    else{// 新增备忘录
        // 精确到秒的就是10位数字，精确到毫秒的就是13位数字
        
        NSDate* dat = [NSDate date];
        NSUInteger uid=(NSUInteger)[dat timeIntervalSince1970];
        NSArray * modelArr = [HomeModel bd_getModelArrWithCheck:NO];
        NSMutableArray * arr = [NSMutableArray arrayWithArray:modelArr];
        HomeModel * model = [[HomeModel alloc] init];
        model.area = textView.text;
        model.uid = uid;
        [arr insertObject:model atIndex:0];
        
        myBlock([arr copy]);
        
    }
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [textView resignFirstResponder];
}


@end
