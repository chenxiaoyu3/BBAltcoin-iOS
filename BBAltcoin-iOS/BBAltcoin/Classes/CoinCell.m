//
//  CoinCell.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinCell.h"
#import "DataCenter.h"

@implementation CoinCell

- (id)initWithFrame:(CGRect)frame andCoin:(int)coinID
{
    self = [super initWithFrame:frame];
    if (self) {
        self.coinID = coinID;
        
        self.abbrLabel = [[UILabel alloc] init];
        self.abbrLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        self.abbrLabel.text = [[DataCenter sharedInstance] coinAbbrOfID:coinID];
        self.abbrLabel.textColor = [UIColor whiteColor];
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.text = [[DataCenter sharedInstance] coinNameOfID:coinID];
        self.nameLabel.textColor = [UIColor whiteColor];
        
        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.text = @"-.---";
        self.priceLabel.textColor = [UIColor whiteColor];
        [self.abbrLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.abbrLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        
        
        NSDictionary* views = NSDictionaryOfVariableBindings(_abbrLabel, _nameLabel, _priceLabel);
        [self addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_abbrLabel]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_abbrLabel]-[_nameLabel]-[_priceLabel]" options:0 metrics:nil views:views]];
        
    }
    return self;
}


@end