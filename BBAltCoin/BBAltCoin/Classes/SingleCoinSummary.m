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
    self.coinPriceLabel.showSymbol = YES;
    self.coinPriceBuyLabel.textColor = [[Theme curTheme] textcolor2];
    self.coinPriceBuyLabel.showSymbol = YES;
    self.coinPriceSellLabel.textColor = [[Theme curTheme] textcolor2];
    self.coinPriceSellLabel.showSymbol = YES;
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
    buyText.text = NSLocalizedString(@"TopAsk", nil);
    buyText.font = [UIFont systemFontOfSize:11];
    sellText.text = NSLocalizedString(@"TopBid", nil);
    sellText.font = [UIFont systemFontOfSize:11];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
//    NSLog(path);
    NSArray* views = [NSArray arrayWithObjects:_coinPriceBuyLabel, _coinPriceSellLabel, _coinVolume, nil];
    
    [self.coinNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(8);
        make.right.equalTo(buyText.left);
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
        make.left.equalTo(buyText.right).offset(4);
        make.top.equalTo(self.mas_top).offset(8);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(_coinPriceSellLabel.top);
        make.height.equalTo(views);
    }];
    MASAttachKeys(buyText, self.coinNameLabel, self.coinPriceBuyLabel);
    [buyText makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_coinNameLabel.right);
        make.top.equalTo(self.coinPriceBuyLabel.top);
//        make.right.equalTo(self.coinPriceBuyLabel.left);
        make.centerY.equalTo(self.coinPriceBuyLabel).offset(2);
    }];
    [sellText makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.coinPriceSellLabel).offset(2);
        make.left.and.right.equalTo(buyText);
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
