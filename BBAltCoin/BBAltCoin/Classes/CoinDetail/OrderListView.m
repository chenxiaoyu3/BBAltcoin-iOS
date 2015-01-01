//
//  OrderListView.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/23.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "OrderListView.h"
#import "Macro.h"

@implementation OrderItemView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init{
    [self setupLayout];
    
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = [[Theme curTheme] textColor1];
    _totalPriceLabel.textColor = [[Theme curTheme] textColor1];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _totalPriceLabel.font = [UIFont systemFontOfSize:13];
    self.backgroundColor = [UIColor clearColor];
}
-(void)setupLayout{
    self.priceLabel = [[NumberView alloc] init];
    self.totalPriceLabel = [[NumberView alloc] init];
    [self addSubview:_priceLabel];
    [self addSubview:_totalPriceLabel];
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(4);
        make.right.equalTo(_totalPriceLabel.left);
        make.centerY.equalTo(self.centerY);
    }];
    [_totalPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLabel.right);
        make.right.equalTo(self.right).offset(-4);
        make.centerY.equalTo(self.centerY);
    }];
    
}

- (void)setOrder:(OrderItem *)order{
    _order = order;
    
    _priceLabel.number =  order.price;
    _totalPriceLabel.number = order.amt * order.price;
}
- (void)setIndex:(NSUInteger)index{
    if (index % 2 == 1) {
        self.backgroundColor = [[Theme curTheme] bgColor3];
    }
}

- (void)drawRect:(CGRect)rect{
    // TODO: bg matrix bell
    
}

@end


@implementation OrderListView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init{
    [self setupLayout];
}
-(void) setupLayout{
    _orderItemViews = [NSMutableArray arrayWithCapacity:TOP_ORDER_NUM];
    for (int i = 0; i < TOP_ORDER_NUM; ++i) {
        OrderItemView* v = [[OrderItemView alloc] init];
        v.index = i;
        [_orderItemViews addObject:v];
        [self addSubview:v];
    }
    for (int i = 0; i < TOP_ORDER_NUM; ++i) {
        [_orderItemViews[i] makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.left);
            make.right.equalTo(self.right);
            make.height.equalTo(_orderItemViews);
            if (i == 0) {
                make.top.equalTo(self.top);
            }else{
                make.top.equalTo( ((UIView*)_orderItemViews[i-1]).bottom).offset(4);
            }
            if (i == TOP_ORDER_NUM-1) {
                make.bottom.equalTo(self.bottom);
            }else{
                make.bottom.equalTo(((UIView*)_orderItemViews[i+1]).top).offset(-4);
            }
        }];
    }
}

-(void)setOrders:(NSMutableArray *)orders{
    _orders = orders;
    for (int i= 0; i < TOP_ORDER_NUM; ++i) {
        ((OrderItemView*)_orderItemViews[i]).order = orders[i];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
