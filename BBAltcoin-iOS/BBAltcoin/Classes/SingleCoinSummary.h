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

@interface SingleCoinSummary : UIView

@property (nonatomic, strong) UIView* view;

@property (nonatomic, strong) UILabel* testLabel;
@property (nonatomic, strong) UILabel* marketFrom;
@property (nonatomic, strong) UILabel* coinName;
@property (nonatomic, strong) NumberView* price;

@property (nonatomic) int coinID;

@end
