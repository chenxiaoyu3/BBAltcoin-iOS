//
//  CoinSummaryViewController.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinDetailViewController.h"
#import "Utils.h"
#import "CoinListTableViewCell.h"

@interface CoinDetailViewController ()

@end

@implementation CoinDetailViewController

-(void)_init{
    
    [self setupLayout];
    
    self.coinListTableView.delegate = self;
    self.coinListTableView.dataSource = self;
    
//    self.leftView.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [[Theme curTheme] themeColor1];
    self.coinListTableView.backgroundView = nil;
    self.coinListTableView.backgroundColor = [UIColor clearColor];
    self.coinListTableView.separatorInset = UIEdgeInsetsZero;
    self.coinListTableView.layoutMargins = UIEdgeInsetsZero;
    self.coinListTableView.separatorColor = [UIColor clearColor];
}

-(void)setupLayout{
    self.view.backgroundColor = [[Theme curTheme] themeColor1];
    self.mainCoinView = [[SingleCoinSummary alloc] init];
//    [self.view addSubview:self.mainCoinView];
////    self.navigationController.navigationBar.translucent = NO;
//    
//    [self.mainCoinView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.top.equalTo(self.view.mas_top);
////        make.bottom.equalTo(self.view.mas_bottom).offset(100);
//        make.height.equalTo(@50);
//    }];
    self.leftView = [[UIView alloc] init];
    [self.view addSubview:self.leftView];
    self.rightView = [[UIView alloc] init];
    [self.view addSubview:self.rightView];
    self.coinListTableView = [[UITableView alloc] init];
    [self.leftView addSubview:self.coinListTableView];

    UIEdgeInsets insets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(insets.top);
        make.left.equalTo(self.leftView.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(insets.bottom);
        make.right.equalTo(self.view.mas_right).offset(insets.right);

    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(insets.top);
        make.left.equalTo(self.view.mas_left).offset(insets.left);
        make.bottom.equalTo(self.view.mas_bottom).offset(insets.bottom);
        make.right.equalTo(self.rightView.mas_left);
        make.width.equalTo(@75);
    }];
    [self.coinListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftView);
    }];
    
   

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _init];
//    self.mainCoinView.coinID = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* tableViewId = @"tableViewId";
    CoinListTableViewCell* ret = [self.coinListTableView dequeueReusableCellWithIdentifier:tableViewId];
    if (ret == nil) {
        ret = [[CoinListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewId];
    }
    ret.coinID = indexPath.row;
    return ret;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger ret = [[DataCenter center] coinNum];
    return ret;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
