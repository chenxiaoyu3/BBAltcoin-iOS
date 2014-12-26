//
//  SingleCoinSummary.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "SingleCoinSummary.h"
#import "Theme.h"
@implementation SingleCoinSummary


-(void)_init{
    [self setupLayout];
    self.coinNameLabel.textColor = [UIColor yellowColor];
    self.coinNameLabel.font = [UIFont systemFontOfSize:16];
    self.coinPriceLabel.textColor = [[Theme curTheme] textColor1];
    self.coinPriceLabel.font = [UIFont systemFontOfSize:20];
    self.coinPriceBuyLabel.textColor = [[Theme curTheme] textcolor2];
    self.coinPriceSellLabel.textColor = [[Theme curTheme] textcolor2];
}

-(void) setupLayout{
    self.coinNameLabel = [[UILabel alloc] init];
    [self addSubview:self.coinNameLabel];
    self.coinPriceBuyLabel = [[NumberView alloc] init];
    [self addSubview:self.coinPriceBuyLabel];
    self.coinPriceSellLabel = [[NumberView alloc] init];
    [self addSubview:self.coinPriceSellLabel];
    self.coinPriceLabel = [[NumberView alloc] init];
    [self addSubview:self.coinPriceLabel];
    self.coinVolume = [[NumberView alloc] init];
    [self addSubview:self.coinVolume];
    
    NSArray* views = [NSArray arrayWithObjects:_coinPriceBuyLabel, _coinPriceSellLabel, _coinVolume, nil];
    [self.coinNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(8);
        make.right.equalTo(_coinPriceBuyLabel.left).offset(-8);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [self.coinPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinNameLabel.left);
        make.top.equalTo(_coinNameLabel.bottom).offset(8);
        make.right.equalTo(_coinPriceBuyLabel.left);
        make.height.equalTo(@20);
    }];
    [self.coinPriceBuyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinNameLabel.right).offset(8);
        make.top.equalTo(self.mas_top).offset(8);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_coinPriceSellLabel.top);
        make.height.equalTo(views);
    }];
    [self.coinPriceSellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinPriceBuyLabel.left);
        make.top.equalTo(_coinPriceBuyLabel.bottom);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.coinVolume.top);
        make.height.equalTo(views);
    }];
    [self.coinVolume makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinPriceSellLabel.left);
        make.right.equalTo(self.right);
        make.bottom.equalTo(self.bottom);
        make.top.equalTo(self.coinPriceSellLabel.bottom);
        make.height.equalTo(views);
    }];
    
}
-(id)init{
    self = [super init];
    [self _init];
    return self;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}


-(void)setCoinID:(NSUInteger)coinID{
    _coinID = coinID;
    self.coinNameLabel.text = [[DataCenter center] coinNameOfID:coinID];
    Coin* c = [[DataCenter center] coinOfID:_coinID];
    self.coinPriceLabel.number = c.price;
    self.coinPriceBuyLabel.number = c.buyPrice;
    self.coinPriceSellLabel.number = c.sellPrice;
}

#pragma mark - DataCenter

- (void)priceRequestCompletedWithStatus:(int)st{
    if (st == 0) {
        Coin* c = [[DataCenter center] coinOfID:_coinID];
        self.coinPriceLabel.number = c.price;
        self.coinPriceBuyLabel.number = c.buyPrice;
        self.coinPriceSellLabel.number = c.sellPrice;
    }
}
@end
