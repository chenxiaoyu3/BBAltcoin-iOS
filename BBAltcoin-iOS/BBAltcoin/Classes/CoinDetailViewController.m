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
    
    self.coinNameLabel.textColor = [UIColor yellowColor];
    self.coinNameLabel.font = [UIFont systemFontOfSize:22];
    self.coinPriceBuyLabel.textColor = [[Theme curTheme] textColor1];
    [self setSelectedCoinID:2];
}

-(void)setupLayout{
    self.view.backgroundColor = [[Theme curTheme] themeColor1];
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
        make.right.equalTo(self.view.mas_right).offset(-insets.right);

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
    
    // in right view
    self.coinNameLabel = [[UILabel alloc] init];
    [self.rightView addSubview:self.coinNameLabel];
    self.coinPriceBuyLabel = [[UILabel alloc] init];
    [self.rightView addSubview:self.coinPriceBuyLabel];
    self.coinPriceSellLabel = [[UILabel alloc] init];
    [self.rightView addSubview:self.coinPriceSellLabel];
    [self.coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightView.mas_left).offset(10);
        make.top.equalTo(_rightView.mas_top).offset(20);
        make.right.equalTo(_coinPriceBuyLabel.left).offset(-8);
        make.width.equalTo(_coinPriceBuyLabel.mas_width);
        
    }];
    [self.coinPriceBuyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinNameLabel.right).offset(8);
        make.top.equalTo(_rightView.mas_top).offset(8);
        make.right.equalTo(_rightView.mas_right);
    }];
    
    // two orders view
    self.buyOrdersView = [[OrderListView alloc] init];
    self.sellOrdersView = [[OrderListView alloc] init];
    [self.rightView addSubview:self.buyOrdersView];
    [self.rightView addSubview:self.sellOrdersView];
    
    [self.buyOrdersView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightView.left);
        make.right.equalTo(_sellOrdersView.left).offset(-10);
        make.top.equalTo(_coinNameLabel.bottom).offset(50);
        make.height.equalTo(@300);
        make.width.equalTo(_sellOrdersView);
    }];
    [self.sellOrdersView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_buyOrdersView.right).offset(10);
        make.right.equalTo(_rightView.right);
        make.top.equalTo(_buyOrdersView.top);
        make.bottom.equalTo(_buyOrdersView.bottom);
        make.width.equalTo(_buyOrdersView.width);
    }];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self _init];
    
    [[DataCenter center] requestCoinDetail];
}

-(void)viewWillAppear:(BOOL)animated{
    [[DataCenter center] addDataObserver:self];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [[DataCenter center] removeDataObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedCoinID:(NSUInteger)selectedCoinID{
    _selectedCoinID = selectedCoinID;
    self.coinNameLabel.text = [[DataCenter center] coinAbbrOfID:selectedCoinID];
    
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

#pragma mark - DataCenter

-(void)coinDetailRequestCompletedWithStatus:(int)st{
    if (st == 0) {
        self.buyOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.buyOrder;
        self.sellOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.sellOrder;
    }
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
