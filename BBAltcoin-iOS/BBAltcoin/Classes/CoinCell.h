//
//  CoinCell.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CoinCell : UIView

@property (nonatomic) int coinID;
@property (nonatomic, strong) UILabel *abbrLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

- (id)initWithFrame:(CGRect)frame andCoin:(int)coinID;
@end

