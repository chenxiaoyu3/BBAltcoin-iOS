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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        // TODO: this line cannot be added in layoutSubview methods, why?
        self.selectedBackgroundView = [Utils viewOfFrame:self.frame andColor:[Theme curTheme].themeColor2];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    }
- (void)setCoinID:(NSUInteger)coinID{
    self.textLabel.text = [[DataCenter center] coinAbbrOfID:coinID];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
