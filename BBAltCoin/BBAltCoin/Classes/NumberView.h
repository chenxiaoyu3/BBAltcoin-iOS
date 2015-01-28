//
//  NumberView.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/18.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberView : UIView

@property (nonatomic) float number;
@property (nonatomic, strong) UILabel* mainLabel;
@property (nonatomic, strong) UILabel* leftLabel;
@property (nonatomic) BOOL showSymbol;
@property (nonatomic) BOOL leaveSymbolSpace;
@property (nonatomic) BOOL changeColorAutomatically;
#pragma mark - Fake to be a UILabel
@property (nonatomic, strong) UIFont* font;
@property (nonatomic) NSTextAlignment   textAlignment;
@property (nonatomic, strong) UIColor* textColor;

-(void)setNumber:(float)number andChangeColorAuto:(BOOL)changeColorAuto;
@end
