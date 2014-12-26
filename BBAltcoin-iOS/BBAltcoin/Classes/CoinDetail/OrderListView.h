//
//  OrderListView.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/23.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Coin.h"
#import "NumberView.h"

@interface OrderItemView : UIView

@property (nonatomic, strong) NumberView* priceLabel;
@property (nonatomic, strong) NumberView* totalPriceLabel;
@property (nonatomic, strong) OrderItem* order;

@property (nonatomic) NSUInteger index;
@end



@interface OrderListView : UIView

@property (nonatomic, strong) NSMutableArray* orderItemViews;
@property (nonatomic, weak) NSMutableArray* orders;
@end
