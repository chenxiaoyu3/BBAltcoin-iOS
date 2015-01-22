//
//  ChartViewController.h
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/22.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "BBStockChart.h"

@interface ChartViewController : UIViewController<DataCenterDelegate>

@property (nonatomic) NSUInteger coinID;
@property (nonatomic) BBChartView* chartView;

- (instancetype)initWithCoin:(NSUInteger )coinID;
@end
