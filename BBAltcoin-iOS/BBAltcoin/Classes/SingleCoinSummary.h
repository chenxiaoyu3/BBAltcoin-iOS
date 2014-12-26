//
//  SingleCoinSummary.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved..
//

#import <UIKit/UIKit.h>
#import "NumberView.h"
#import "DataCenter.h"
#import "Masonry.h"

@interface SingleCoinSummary : UIView<DataCenterDelegate>

@property (nonatomic, strong) UILabel* coinNameLabel;
@property (nonatomic, strong) NumberView* coinPriceBuyLabel;
@property (nonatomic, strong) NumberView* coinPriceSellLabel;
@property (nonatomic, strong) NumberView* coinPriceLabel;
@property (nonatomic, strong) NumberView* coinVolume;

@property (nonatomic) NSUInteger coinID;

@end
