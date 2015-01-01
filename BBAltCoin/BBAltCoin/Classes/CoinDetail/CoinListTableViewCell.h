//
//  TableViewCell.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/20.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* coinNameLabel;
@property (nonatomic, strong) UILabel* coinPriceLabel;
@property (nonatomic, strong) UIImageView* coinLogo;

@property (nonatomic) NSUInteger coinID;

@end
