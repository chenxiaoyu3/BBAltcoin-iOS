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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        int parWidth = frame.size.width;
        int parHeight = frame.size.height;
        int curY = 4;
        self.backgroundColor = [UIColor colorWithWhite:255 alpha:0.3];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, curY, parWidth, parHeight*0.2)];
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
//        self.nameLabel.backgroundColor = [UIColor yellowColor];
        
        curY += parHeight*0.2 + 4;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, curY, parWidth, parHeight*0.4)];
        self.priceLabel.text = @"122.32";
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.textColor = [UIColor whiteColor];
//        self.priceLabel.backgroundColor = [UIColor yellowColor];
        curY += parHeight * 0.4 + 4;
        self.increaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, curY, parWidth, parHeight*0.2)];
        self.increaseLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        self.increaseLabel.textColor = [UIColor whiteColor];
        

        [self addSubview:self.increaseLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
        
    }
    return self;
}

-(void) setCoinID:(int)coinID{
    _coinID = coinID;
    self.nameLabel.text = [[DataCenter sharedInstance] coinNameOfID:coinID];
    self.increaseLabel.text = [[DataCenter sharedInstance] coinAbbrOfID:coinID];
}


@end