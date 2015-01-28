//
//  MainViewController.h
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuViewController.h"
#import "CoinDetailViewController.h"
#import "CoinOverallViewController.h"
#import "ECSlidingViewController.h"
#import "NavController.h"

@interface MainViewController : ECSlidingViewController<MenuDelegate, CoinOverallViewControllerDelegate>

@property (nonatomic) LeftMenuViewController* leftMenuViewController;
@property (nonatomic) CoinDetailViewController* coinDetailViewController;
@property (nonatomic) CoinOverallViewController* coinOverallViewController;

@end
