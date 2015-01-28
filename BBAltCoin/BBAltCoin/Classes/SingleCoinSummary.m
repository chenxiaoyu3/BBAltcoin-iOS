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
    self.backgroundColor = [UIColor clearColor];
    self.coinNameLabel.textColor = [UIColor yellowColor];
    self.coinNameLabel.font = [UIFont systemFontOfSize:14];

    self.coinPriceLabel.font = [UIFont systemFontOfSize:22];
    self.coinPriceLabel.showSymbol = YES;

    self.coinPriceBuyLabel.font = [UIFont systemFontOfSize:12];
    self.coinPriceBuyLabel.showSymbol = YES;
    self.coinPriceSellLabel.font = [UIFont systemFontOfSize:12];
    self.coinPriceSellLabel.showSymbol = YES;
    
    self.coinVolume.font = [UIFont systemFontOfSize:12];
    self.coinVolume.leaveSymbolSpace = YES;
    self.coinVolume.changeColorAutomatically = NO;

    
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
    
    UILabel* buyText = [[UILabel alloc] init];
    buyText.textColor = [[Theme curTheme] textColor1];
    [self addSubview:buyText];
    UILabel* sellText = [[UILabel alloc] init];
    sellText.textColor = [[Theme curTheme] textColor1];
    [self addSubview:sellText];
    UILabel* volText = UILabel.new;
    volText.textColor = [[Theme curTheme] textColor1];
    [self addSubview:volText];
    buyText.text = NSLocalizedString(@"TopAsk", nil);
    buyText.font = [UIFont systemFontOfSize:11];
    sellText.text = NSLocalizedString(@"TopBid", nil);
    sellText.font = [UIFont systemFontOfSize:11];
    volText.text = NSLocalizedString(@"Volume", nil);
    volText.font = [UIFont systemFontOfSize:11];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
//    NSLog(path);
    NSArray* views = [NSArray arrayWithObjects:_coinPriceBuyLabel, _coinPriceSellLabel, _coinVolume, nil];
    
    [self.coinNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(8);
//        make.right.equalTo(buyText.left);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [self.coinPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinNameLabel.left);
        make.top.equalTo(_coinNameLabel.bottom).offset(8);
//        make.right.equalTo(_coinPriceBuyLabel.left);
        make.height.equalTo(@20);
    }];
    
    //右边并排三个 price 靠右对齐
    [self.coinPriceBuyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@70);
        make.top.equalTo(self.mas_top).offset(4);
        make.right.equalTo(self.mas_right).offset(-14);
        make.bottom.equalTo(_coinPriceSellLabel.top);
        make.height.equalTo(views);
    }];
    [self.coinPriceSellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_coinPriceBuyLabel.bottom);
        make.left.right.equalTo(self.coinPriceBuyLabel);
        make.bottom.equalTo(self.coinVolume.top);
        make.height.equalTo(views);
    }];
    [self.coinVolume makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.coinPriceBuyLabel);
        make.bottom.equalTo(self.bottom).offset(-4);
        make.top.equalTo(self.coinPriceSellLabel.bottom);
        make.height.equalTo(views);
    }];
    
    
    MASAttachKeys(buyText, self.coinNameLabel, self.coinPriceBuyLabel);
    [buyText makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_coinNameLabel.right);
        make.top.equalTo(self.coinPriceBuyLabel.top);
        make.right.equalTo(self.coinPriceBuyLabel.left).offset(-4);
        make.centerY.equalTo(self.coinPriceBuyLabel).offset(2);
    }];
    [sellText makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinPriceSellLabel).offset(2);
        make.left.and.right.equalTo(buyText);
    }];
    [volText makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinVolume).offset(2);
        make.left.and.right.equalTo(buyText);
    }];
    
}
-(id)init{
    self = [super init];
    [self _init];
    return self;
}


-(void)setCoinID:(NSUInteger)coinID{
    _coinID = coinID;
    self.coinNameLabel.text = [[DataCenter center] coinAbbrOfID:coinID];
    Coin* c = [[DataCenter center] coinOfID:_coinID];
    [self.coinPriceLabel setNumber:c.price andChangeColorAuto:NO];
    [self.coinPriceBuyLabel setNumber:c.buyPrice andChangeColorAuto:NO];
    [self.coinPriceSellLabel setNumber:c.sellPrice andChangeColorAuto:NO];
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

- (void)chartDataRequestCompleted:(NSUInteger)coinID chartType:(CoinChartType)type withStatus:(int)st andData:(NSArray *)data{
    CGFloat vol = 0;
    if (st == 0 && type == ChartTime && coinID == self.coinID) {
        for (NSArray* arr in data){
            vol += Float(arr[1]);
        }
    }
    self.coinVolume.number = vol;
}
@end
