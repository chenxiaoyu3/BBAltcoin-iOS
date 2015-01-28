//
//  CoinCell.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "NumberView.h"

@interface CoinCell : UIView <DataCenterDelegate>


@property (nonatomic) int coinID;
@property (nonatomic, strong) UILabel *increaseLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) NumberView *priceLabel;
@property (nonatomic, strong) UIImageView *triangleImageView;

+(UIImage*) triangleImageOfType:(int) type;

@end

