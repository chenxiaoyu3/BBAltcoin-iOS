//
//  CoinCell.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinCell.h"
#import "DataCenter.h"
#import "Masonry.h"


@implementation CoinCell


- (id) init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:255 alpha:0.4];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        //        self.nameLabel.backgroundColor = [UIColor yellowColor];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.text = @"100";
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.textColor = [UIColor whiteColor];
        [self.priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
//                self.priceLabel.backgroundColor = [UIColor yellowColor];

        self.triangleImageView = [[UIImageView alloc] initWithImage:[CoinCell triangleImageOfType:0]];
        [self.triangleImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.increaseLabel = [[UILabel alloc] init];
        self.increaseLabel.font = [UIFont systemFontOfSize:10];
        self.increaseLabel.textColor = [UIColor whiteColor];
        [self.increaseLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UIView * bottomView = [[UIView alloc] init];
        [bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [bottomView addSubview:self.triangleImageView];
        [bottomView addSubview:self.increaseLabel];
//        [bottomView setBackgroundColor:[UIColor yellowColor]];
        
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
        }];
        [self.increaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.triangleImageView.mas_right).offset(4);
            make.right.equalTo(bottomView);
            make.top.equalTo(bottomView);
            make.bottom.equalTo(bottomView);
        }];
        

    }
    return self;
}

-(void) setCoinID:(int)coinID{
    _coinID = coinID;
    self.nameLabel.text = [[DataCenter center] coinNameOfID:coinID];
    self.increaseLabel.text = [[DataCenter center] coinAbbrOfID:coinID];
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
        self.priceLabel.text = [NSString stringWithFormat:@"%0.3f",
                                    [[DataCenter center] coinOfID:self.coinID].buyPrice
                                ];
    }
}

@end