//
//  NumberView.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "NumberView.h"

@implementation NumberView

-(void)setNumber:(float)number{
    _number = number;
    if (number > 1000) {
        self.text = [NSString stringWithFormat:@"%.1f", number];
    }else{
        self.text = [NSString stringWithFormat:@"%.3f", number];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
