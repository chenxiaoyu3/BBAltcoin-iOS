//
//  LeftMenuViewController.h
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuDelegate <NSObject>

@optional
-(void)onCoinOverallBtnClicked;
-(void)onCoinDetailBtnClicked;

@end

@interface LeftMenuViewController : UIViewController

@property (nonatomic) UIButton* coinOverallBtn;
@property (nonatomic) UIButton* coinDetailBtn;

@property (nonatomic) id<MenuDelegate> delegate;

@end
