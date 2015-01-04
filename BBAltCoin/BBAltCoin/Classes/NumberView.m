//
//  NumberView.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "NumberView.h"

@implementation NumberView

-(void) _init{

    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.text = @"￥";
    self.leftLabel.font = [UIFont systemFontOfSize:self.mainLabel.font.pointSize-5];
//    self.leftLabel.backgroundColor = [Theme whiteColor];
    
    [self addSubview:self.leftLabel];
    
    self.mainLabel = [[UILabel alloc] init];
    [self addSubview:self.mainLabel];
//    self.mainLabel.backgroundColor = [Theme redColor];
    	

    [self.leftLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        //make.right.equalTo(_mainLabel.left);
        make.bottom.equalTo(_mainLabel.bottom);
    }];
    [self.mainLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.right).offset(-3);
        make.right.equalTo(self.right);
        make.centerY.equalTo(self.centerY);
// Tip: I did not use bottom align to make the leftLabel's bottom align working properly
//        make.bottom.equalTo(self.bottom);
    }];
    [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@0);
    }];
    
}

- (void)updateConstraints{
    if (self.showSymbol) {
        [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@15);
        }];
    }else{
        [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@0);
        }];

    }
    [super updateConstraints];
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}
-(void)setNumber:(float)number{
    _number = number;
    if (number > 1000) {
        self.mainLabel.text = [NSString stringWithFormat:@"%.1f", number];
    }else{
        self.mainLabel.text = [NSString stringWithFormat:@"%.3f", number];
    }
}

- (void)setShowSymbol:(BOOL)showSymbol{
    _showSymbol = showSymbol;
    [self updateConstraints];
}

-(void)setFont:(UIFont *)font{
    self.mainLabel.font = font;
    self.leftLabel.font = [UIFont fontWithName:font.familyName size:font.pointSize-5];
}

- (UIFont *)font{
    return self.mainLabel.font;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment{
    self.mainLabel.textAlignment = textAlignment;
}
- (NSTextAlignment)textAlignment{
    return self.mainLabel.textAlignment;
}

- (void)setTextColor:(UIColor *)textColor{
    self.mainLabel.textColor = textColor;
    self.leftLabel.textColor = textColor;
}

- (UIColor *)textColor{
    return self.mainLabel.textColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
