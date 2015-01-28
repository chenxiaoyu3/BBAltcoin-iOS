//
//  CoinCell.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinCell.h"
#import "DataCenter.h"
#import "BBTheme.h"

@interface CoinCell()
@property (nonatomic) CGFloat lastNumber;
@end

@implementation CoinCell


- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:255 alpha:0.2];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        
        self.priceLabel = [[NumberView alloc] init];
        self.priceLabel.textColor = [UIColor whiteColor];

        self.triangleImageView = [[UIImageView alloc] initWithImage:[CoinCell triangleImageOfType:0]];
        
        self.increaseLabel = [[UILabel alloc] init];
        self.increaseLabel.font = [UIFont systemFontOfSize:10];
        self.increaseLabel.textColor = [UIColor whiteColor];
        
        UIView * bottomView = [[UIView alloc] init];
        [bottomView addSubview:self.triangleImageView];
        [bottomView addSubview:self.increaseLabel];
        
        [self addSubview:bottomView];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.priceLabel.mas_top).offset(-4);
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(bottomView.mas_top).offset(-2);
            make.height.greaterThanOrEqualTo(@20);
        }];
        

        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.triangleImageView);
            make.right.equalTo(self.increaseLabel);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(2);
            make.bottom.equalTo(self.mas_bottom).offset(-2);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
        [self.triangleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left);
            make.right.equalTo(self.increaseLabel.mas_left).offset(-4);
            make.top.equalTo(bottomView);
            make.bottom.equalTo(bottomView);
            make.height.width.equalTo(@10);
        }];
        [self.increaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.triangleImageView.mas_right).offset(4);
            make.right.equalTo(bottomView);
            make.top.equalTo(bottomView);
            make.bottom.equalTo(bottomView);
        }];
        

    }
    self.lastNumber = -1;
    self.nameLabel.text = @"abc";
    return self;
}

-(void) setCoinID:(int)coinID{
    _coinID = coinID;
    self.nameLabel.text = [[DataCenter center] coinNameOfID:coinID];
    self.increaseLabel.text = @"0.00%";
}

-(void)updateConstraints{
    
    [super updateConstraints];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"[%d]", self.coinID];
}

+(UIImage*) triangleImageOfType:(int)type{
    static UIImage* up = nil, *down = nil, *even = nil;
    if(up == nil || down == nil || even == nil){
        up = [UIImage imageNamed:@"triangle_up"];
        down = [UIImage imageNamed:@"triangle_down"];
        even = [UIImage imageNamed:@"triangle_m"];
    }
    return type == 1 ? up : type == 0 ? even : down;
}

# pragma mark - DataCenterDelegate
-(void)priceRequestCompletedWithStatus:(int)st{
    if (st == 0) {
        CGFloat number = [[DataCenter center] coinOfID:self.coinID].buyPrice;
        self.priceLabel.number = number;
        if (self.lastNumber >= 0) {
            if (self.lastNumber > number) {
                self.triangleImageView.image = [CoinCell triangleImageOfType:-1];
                self.increaseLabel.textColor = [BBTheme defTheme].fallColor;
                self.increaseLabel.text = [NSString stringWithFormat:@"%.2f%%",100*(self.lastNumber - number)/self.lastNumber];
            }else if(self.lastNumber < number){
                self.triangleImageView.image = [CoinCell triangleImageOfType:1];
                self.increaseLabel.textColor = [BBTheme defTheme].riseColor;
                self.increaseLabel.text = [NSString stringWithFormat:@"%.2f%%",100*(number - self.lastNumber)/self.lastNumber];
            }else{
                self.triangleImageView.image = [CoinCell triangleImageOfType:0];
                self.increaseLabel.textColor = [BBTheme whiteColor];
                self.increaseLabel.text = @"0.00%";
            }
        }
        self.lastNumber = number;
    }
}

@end