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

@interface CoinDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSUInteger selectedCoinID;

@property (nonatomic, strong) UITableView* coinListTableView;
@property (nonatomic, strong) UIView* leftView;
@property (nonatomic, strong) UIView* rightView;

@property (nonatomic, strong) UILabel* coinNameLabel;
@property (nonatomic, strong) UILabel* coinPriceBuyLabel;
@property (nonatomic, strong) UILabel* coinPriceSellLabel;
@end
