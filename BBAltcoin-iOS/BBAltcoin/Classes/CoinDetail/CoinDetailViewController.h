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

@interface CoinDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, DataCenterDelegate>

@property (nonatomic) NSUInteger selectedCoinID;

@property (nonatomic, strong) UITableView* coinListTableView;
@property (nonatomic, strong) UIView* leftView;

// right view
@property (nonatomic, strong) UIView* rightView;

@property (nonatomic, strong) SingleCoinSummary* coinSummary;
//@property (nonatomic, strong) UILabel* coinNameLabel;
//@property (nonatomic, strong) UILabel* coinPriceBuyLabel;
//@property (nonatomic, strong) UILabel* coinPriceSellLabel;
//@property (nonatomic, strong) UILabel* coinPriceLabel;
//@property (nonatomic, strong) UILabel* coinVolume;

@property (nonatomic, strong) UIView* orderSectionView;
@property (nonatomic, strong) OrderListView* buyOrdersView;
@property (nonatomic, strong) OrderListView* sellOrdersView;

@end
