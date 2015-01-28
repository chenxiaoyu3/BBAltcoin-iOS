//
//  ViewController.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAPullToRefresh.h"
#import "DataCenter.h"

@interface CoinOverallViewController : UIViewController<DataCenterDelegate>{
    NSArray* _constraintsArray;
}


@property (nonatomic, strong) UIView* coinCellsContainer;
@property (nonatomic, strong) NSMutableArray* coinCells;

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* scrollViewContainer;

@property (nonatomic, strong) AAPullToRefresh* pullToRefresh;
@end

