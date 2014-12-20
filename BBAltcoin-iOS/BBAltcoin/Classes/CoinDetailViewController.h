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

@property (nonatomic, strong)  UILabel* testLabel;
@property (nonatomic, strong)  SingleCoinSummary* mainCoinView;

@property (nonatomic, strong) UITableView* coinListTableView;
@property (nonatomic, strong) UIView* leftView;
@property (nonatomic, strong) UIView* rightView;
@end
