//
//  CoinSummaryViewController.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCoinSummary.h"
#import "Masonry.h"
#import "Theme.h"
#import "OrderListView.h"
#import "BBChartView.h"
#import "AAPullToRefresh.h"

@interface CoinDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DataCenterDelegate, AxisXLabelProvider>

@property (nonatomic) NSUInteger selectedCoinID;

@property (nonatomic, strong) UITableView* coinListTableView;
@property (nonatomic, strong) UIView* leftView;

// right view
@property (nonatomic, strong) UIView* rightView;
@property (nonatomic, strong) UIScrollView* rightDownScorllView;
@property (nonatomic, strong) UIView* rightDownScrollContentView;
@property (nonatomic, strong) AAPullToRefresh* pullToRefresh;

@property (nonatomic, strong) SingleCoinSummary* coinSummary;

@property (nonatomic, strong) UIView* orderSectionView;

@property (nonatomic, strong) OrderListView* buyOrdersView;
@property (nonatomic, strong) OrderListView* sellOrdersView;

@property (nonatomic, strong) BBChartView* chartView;
@property (nonatomic, strong) UIImageView* refreshImageView;

@end
