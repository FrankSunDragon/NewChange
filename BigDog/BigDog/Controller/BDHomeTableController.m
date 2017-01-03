//
//  BDHomeTableController.m
//  BigDog
//
//  Created by Jacky Sun on 2016/11/1.
//  Copyright © 2016年 syf. All rights reserved.
//

#import "BDHomeTableController.h"
#import "DRHFeedbackViewController.h"
#import "HomeModel.h"

@interface BDHomeTableController ()<UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating,UIActionSheetDelegate>
@property (strong, nonatomic)  UISearchController *searchController;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation BDHomeTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSUbviews];
    
}


#pragma mark - UITabelView 代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (!self.searchController.active) ? self.items.count : self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    HomeModel * model = (!self.searchController.active) ? self.items[indexPath.row] : self.searchResults[indexPath.row];
    cell.textLabel.text =  model.area;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 设置为空时，会清空_searchResults数组
    HomeModel * model = (!self.searchController.active) ? self.items[indexPath.row] : self.searchResults[indexPath.row];
    
    [self.searchController setActive:NO];
    DRHFeedbackViewController * fbVC = [[DRHFeedbackViewController alloc] initWithNibName:@"DRHFeedbackViewController" bundle:nil];
    fbVC.model = model;
    [self.navigationController pushViewController:fbVC animated:YES];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = self.searchController.searchBar.text;
    //NSPredicate 谓词  area是模型的属性
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"area contains[cd] %@", searchString];
    
    self.searchResults= [NSMutableArray arrayWithArray:[self.items filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"active"]){
    }
}

- (void)setUpSUbviews{
    self.title = @"BigDog备忘录";
    // 创建uisearchController对象
    UISearchController * searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //搜索时是否隐藏导航栏
    searchController.hidesNavigationBarDuringPresentation = YES;
    searchController.dimsBackgroundDuringPresentation = NO;
    // 添加观察者
    [self.searchController addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionNew context:nil];
    
    self.tableView.tableHeaderView = searchController.searchBar;
    [searchController.searchBar  sizeToFit];
    searchController.searchResultsUpdater = self;
    self.searchController = searchController;
    searchController.searchBar.placeholder=@"请输入Big Dog…";
    searchController.searchBar.barTintColor = DRHColor(23, 37, 78);
    searchController.searchBar.tintColor =  DRHColor(23, 37, 78);
    ;
    searchController.searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    // searchController.searchBar.showsCancelButton=YES;//显示取消按钮
    
  
    [self FD_NavigationBarWithRightBarIMg:@"icon_product" action:@selector(ritgtBarClick)];
    
}

- (void)ritgtBarClick{
    UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"更新(下载)" otherButtonTitles:@"新增",@"上传", nil];
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%zd",buttonIndex);
    if(buttonIndex == 0){// 下载功能
        [self loadInternetData];
    }

  else  if(buttonIndex == 1){// 新增备忘录
        DRHFeedbackViewController * fbVC = [[DRHFeedbackViewController alloc] initWithNibName:@"DRHFeedbackViewController" bundle:nil];
        fbVC.ISNewText = YES;
        [self.navigationController pushViewController:fbVC animated:YES];
    }
  else if (buttonIndex == 2){// 上传功能
      
      [self uploadLocalData];

  }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 每次进入这个页面舒心数据
    _items = [HomeModel bd_getModelArrWithCheck:YES];
    [self.tableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

// 上传本地数据到网上
- (void)uploadLocalData{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"un"] = [SecurityUtil encryptAESData:[GlobalVariables shareGlobalVariables].username secretKey:BigDogArr[3]];
    NSString * ss = [[[[GlobalVariables shareGlobalVariables].username stringByAppendingString:[GlobalVariables shareGlobalVariables].pwd] lowercaseString] md5String];
    dict[@"pwd"] = [SecurityUtil encryptAESData:ss secretKey:BigDogArr[4]];
    NSString * fileData = [HomeModel getUserNotAesData];
    if(fileData.length == 0) return;
    dict[@"d"] =  [SecurityUtil encryptAESData:fileData secretKey:BigDogArr[5]];
    
    [AFNetWorkingGet GET_RequestWithAlertView:bd_upload params:dict isHUD:YES isAlert:YES completion:^(id result) {
        NSLog(@"%@",result);
        
        if(![result[@"errorCode"] boolValue]){//注册成功
            [DRHProgressHUD FDShowClock:result[@"data"]];
        }
        else
            [DRHProgressHUD FDShowClock:result[@"errorMsg"]];
    } failure:^(NSError * error) {
    } connect:^(BOOL connect) {
    }];

}

// 下载网络数据
- (void)loadInternetData{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    
    dict[@"un"] = [SecurityUtil encryptAESData:[GlobalVariables shareGlobalVariables].username secretKey:BigDogArr[3]];
    NSString * ss = [[[[GlobalVariables shareGlobalVariables].username stringByAppendingString:[GlobalVariables shareGlobalVariables].pwd] lowercaseString] md5String];
    dict[@"pwd"] = [SecurityUtil encryptAESData:ss secretKey:BigDogArr[4]];
    
    [AFNetWorkingGet GET_RequestWithAlertView:bd_download params:dict isHUD:YES isAlert:YES completion:^(id result) {
        NSLog(@"%@",result);
        
        if(![result[@"errorCode"] boolValue]){
            [DRHProgressHUD FDShowClock:@"更新成功"];
            
            [HomeModel saveJsonStr:result[@"data"]];
            _items = [HomeModel bd_getModelArrWithCheck:YES];
            [self.tableView reloadData];

            
        }
        else
            [DRHProgressHUD FDShowClock:result[@"errorMsg"]];
    } failure:^(NSError * error) {
    } connect:^(BOOL connect) {
    }];

}

@end
