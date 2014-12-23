//
//  TableViewCell.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/20.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "CoinListTableViewCell.h"
#import "DataCenter.h"
#import "Utils.h"

@implementation CoinListTableViewCell
-(void)setupLayout{
    self.coinLogo = [[UIImageView alloc] initWithImage:[Utils imageWithImage:[UIImage imageNamed:@"BTC_logo"] scaledToSize:CGSizeMake(15, 15)]];
    self.coinNameLabel = [[UILabel alloc] init];
    self.coinPriceLabel = [[UILabel alloc] init];
    
    [self.contentView addSubview:self.coinLogo];
    [self.contentView addSubview:self.coinNameLabel];
    [self.contentView addSubview:self.coinPriceLabel];
    
    [self.coinLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@15);
    }];
    [self.coinNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinLogo.mas_right).offset(8);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.coinPriceLabel.mas_left).offset(-8);
    }];
    [self.coinPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coinNameLabel.mas_right).offset(8);
        make.right.equalTo(self.contentView.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    self.coinNameLabel.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        // TODO: this line cannot be added in layoutSubview methods, why?
        self.selectedBackgroundView = [Utils viewOfFrame:self.frame andColor:[Theme curTheme].themeColor2];
        self.textLabel.backgroundColor = [UIColor redColor];

        [self setupLayout];
        self.coinNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    }
- (void)setCoinID:(NSUInteger)coinID{
    self.coinNameLabel.text = [[DataCenter center] coinAbbrOfID:coinID];

}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
