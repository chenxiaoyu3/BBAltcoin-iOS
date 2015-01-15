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
#import "BBStockChart.h"



@interface CoinDetailViewController ()

@end

@implementation CoinDetailViewController

-(void)_init{
    
    [self setupLayout];
    
    self.title = NSLocalizedString(@"BBAltcoin", nil);
    self.coinListTableView.delegate = self;
    self.coinListTableView.dataSource = self;
    
    self.view.backgroundColor = [[Theme curTheme] themeColor1];
    self.coinListTableView.backgroundView = nil;
    self.coinListTableView.backgroundColor = [UIColor clearColor];
//    self.coinListTableView.separatorInset = UIEdgeInsetsZero;
//    self.coinListTableView.layoutMargins = UIEdgeInsetsZero;
    self.coinListTableView.separatorColor = [UIColor clearColor];
    
    self.rightDownScorllView.canCancelContentTouches = YES;
    self.rightDownScorllView.delaysContentTouches = YES;
    self.chartView.userInteractionEnabled = YES;
    UITapGestureRecognizer* chartViewTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chartViewTaped:)];
    [self.chartView addGestureRecognizer:chartViewTapRecognizer];

    self.selectedCoinID = 0;
}

-(void)setupLayout{
    self.view.backgroundColor = [[Theme curTheme] themeColor1];
    self.leftView = UIView.new;
    [self.view addSubview:self.leftView];
    
    self.rightView = [[UIView alloc] init];
    [self.view addSubview:self.rightView];
    
    
    self.coinListTableView = [[UITableView alloc] init];
    [self.leftView addSubview:self.coinListTableView];

    UIEdgeInsets insets = UIEdgeInsetsMake(48, 8, 8, 8);
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(insets.top);
        make.left.equalTo(self.leftView.mas_right);
        make.bottom.equalTo(self.view.bottom).offset(insets.bottom);
        make.right.equalTo(self.view.mas_right).offset(-insets.right);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).offset(insets.left);
        make.bottom.equalTo(self.view.mas_bottom).offset(insets.bottom);
        make.right.equalTo(self.rightView.mas_left);
        make.width.equalTo(@75);
    }];
    [self.coinListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.leftView);
    }];
    
    // in right view
    
    self.coinSummary = [[SingleCoinSummary alloc] init];
    self.rightDownScorllView = UIScrollView.new;
    [self.rightView addSubview:self.rightDownScorllView];
    [self.rightView addSubview:self.coinSummary];
    
    [self.coinSummary makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightView.mas_left).offset(10);
        make.top.equalTo(_rightView.mas_top).offset(20);
        make.right.equalTo(_rightView.right);
        make.height.equalTo(@80);
    }];
    [self.rightDownScorllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(_rightView);
        make.top.equalTo(self.coinSummary.bottom).offset(8);
    }];
    self.rightDownScrollContentView = UIView.new;
    [self.rightDownScorllView addSubview:self.rightDownScrollContentView];
    [self.rightDownScrollContentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rightDownScorllView);
        //这个不添加，rightView 与它的父 的右边 会有一点padding， why?
        make.width.equalTo(self.rightDownScorllView).offset(-5);
    }];
    // two orders view
    self.orderSectionView = [[UIView alloc] init];
    self.buyOrdersView = [[OrderListView alloc] init];
    self.sellOrdersView = [[OrderListView alloc] init];
    
    UILabel* askLabel = [[UILabel alloc] init];
    askLabel.textColor = [[Theme curTheme] greenForText1];
    askLabel.font = [UIFont systemFontOfSize:13];
    askLabel.text = NSLocalizedString(@"Ask", nil);
    UIView* askLabelLine = [[UIView alloc] init];
    askLabelLine.backgroundColor = [[Theme curTheme] greenForText1];
    
    UILabel* bidLabel = [[UILabel alloc] init];
    bidLabel.textColor = [[Theme curTheme] redForText1];
    bidLabel.font = [UIFont systemFontOfSize:13];
    bidLabel.text = NSLocalizedString(@"Bid", nil);
    UIView* bidLabelLine = [[UIView alloc] init];
    bidLabelLine.backgroundColor = [[Theme curTheme] redForText1];
    
    
    [self.rightDownScrollContentView addSubview:self.orderSectionView];
    [self.orderSectionView addSubview:self.buyOrdersView];
    [self.orderSectionView addSubview:self.sellOrdersView];
    [self.orderSectionView addSubview:askLabel];
    [self.orderSectionView addSubview:askLabelLine];
    [self.orderSectionView addSubview:bidLabel];
    [self.orderSectionView addSubview:bidLabelLine];
    
    
    [self.orderSectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightDownScrollContentView.left).offset(8);
        make.right.equalTo(_rightDownScrollContentView.right).offset(8);
        make.top.equalTo(_rightDownScrollContentView.top);
        make.height.equalTo(@250);
    }];
    [askLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(_orderSectionView).offset(2);
    }];
    [askLabelLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_buyOrdersView);
        make.top.equalTo(askLabel.bottom).offset(2);
        make.height.equalTo(@1);
    }];
    [bidLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderSectionView).offset(2);
        make.left.equalTo(_sellOrdersView).offset(2);
    }];
    [bidLabelLine makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(_sellOrdersView);
        make.top.equalTo(bidLabel.bottom).offset(2);
        make.height.equalTo(@1);
    }];
    [self.buyOrdersView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderSectionView.left);
        make.right.equalTo(_sellOrdersView.left).offset(-10);
        make.top.equalTo(askLabelLine.bottom).offset(2);
        make.bottom.equalTo(_orderSectionView.bottom);
        make.width.equalTo(_sellOrdersView);
    }];
    [self.sellOrdersView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_buyOrdersView.right).offset(10);
        make.right.equalTo(_orderSectionView.right);
        make.top.equalTo(_buyOrdersView.top).offset(2);
        make.bottom.equalTo(_buyOrdersView.bottom);
        make.width.equalTo(_buyOrdersView.width);
    }];
    
//    Chart
    self.chartView = [[BBChartView alloc] init];
    [self.rightDownScrollContentView  addSubview:self.chartView];
    [self.chartView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderSectionView.bottom).offset(14);
        make.height.equalTo(@200);
        make.left.and.right.equalTo(_rightDownScrollContentView);
    }];
    // 必须添加bottom ，否则内部view的height 对不上（scrollView会一直以为内部view的height是0）
    [self.rightDownScrollContentView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chartView.bottom).offset(50);
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
    [[DataCenter center] addDataObserver:self.coinSummary];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [[DataCenter center] removeDataObserver:self];
    [[DataCenter center] removeDataObserver:self.coinSummary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSelectedCoinID:(NSUInteger)selectedCoinID{
    _selectedCoinID = selectedCoinID;
    self.coinSummary.coinID = selectedCoinID;
    self.buyOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.buyOrder;
    self.sellOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.sellOrder;
    
    [[DataCenter center] requestChartDataOfCoin:_selectedCoinID andType:ChartTime];
    
}

- (void)chartViewTaped:(UITapGestureRecognizer*)recognizer{
    NSLog(@"Tap");
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
    return 35;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSUInteger ret = [[DataCenter center] coinNum];
    return ret;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCoinID = indexPath.row;
}

#pragma mark - DataCenter

-(void)coinDetailRequestCompletedWithStatus:(int)st{
    if (st == 0) {
        self.buyOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.buyOrder;
        self.sellOrdersView.orders = ((Coin*)[DataCenter center].coins[self.selectedCoinID]).detail.sellOrder;
    }
}


- (void)chartDataRequestCompleted:(NSArray *)data andType:(CoinChartType)type status:(int)st{
    [self.chartView reset];
    if (st == 0) {
        
        Area* areaup = [[Area alloc] init];
        Area* areadown = [[Area alloc] init];
        BarSeries* bar = [[BarSeries alloc] init];
        StockSeries* stock = [[StockSeries alloc] init];
        [areaup addSeries:stock];
        [areadown addSeries:bar];
        int maxDataNum = 20;
        int cnt = 0;
        for (NSArray* arr in data) {
//            NSLog(@"%f", Float(arr[0]));
            [bar addPoint:Float(arr[1])];
            [stock addPointOpen:Float(arr[2]) close:Float(arr[5]) low:Float(arr[4]) high:Float(arr[3])];
            if (cnt++ > maxDataNum) {
                break;
            }
        }
        
        [self.chartView addArea:areaup];
        [self.chartView addArea:areadown];
        [self.chartView setHeighRatio:0.3 forArea:areadown];
        
        [self.chartView drawAnimated:YES];
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
