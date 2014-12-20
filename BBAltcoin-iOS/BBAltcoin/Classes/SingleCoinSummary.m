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
}

-(void) setupLayout{
    self.marketFrom = [[UILabel alloc] init];
    self.marketFrom.text = @"BTC38";
    self.coinName = [[UILabel alloc] init];
    self.coinName.text = @"BTC";
    self.price = [[NumberView alloc] init];
    [self addSubview:self.marketFrom];
    [self addSubview:self.coinName];
    [self addSubview:self.price];
    
    
    [self.marketFrom mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(8);
        make.top.equalTo(self.mas_top);
        make.width.equalTo(@70);
        make.right.equalTo(self.coinName.mas_left).offset(-8);
        make.height.equalTo(@25);
    }];
    [self.coinName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.marketFrom.mas_right).offset(8);
        make.baseline.equalTo(self.marketFrom.mas_baseline);
        make.width.equalTo(@70);
        make.height.equalTo(@25);
    }];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.marketFrom.mas_left);
        make.top.equalTo(self.marketFrom.mas_bottom).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(self.mas_right);
    }];
    
    self.backgroundColor = [[Theme curTheme] themeColor2];
    self.marketFrom.textColor = [UIColor whiteColor];
    self.price.textColor = [UIColor whiteColor];
    
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


-(void)setCoinID:(int)coinID{
    _coinID = coinID;
    self.coinName.text = [[DataCenter center] coinNameOfID:2];
    self.price.text = @"111111.1";
}

@end
