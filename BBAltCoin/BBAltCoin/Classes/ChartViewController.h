//
//  ChartViewController.h
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/22.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "BBChartView.h"
#import "Area.h"
#import "Series.h"
#import "BarSeries.h"
#import "StockSeries.h"
#import "BBTheme.h"

@interface ChartViewController : UIViewController<DataCenterDelegate, AxisXLabelProvider>

@property (nonatomic) NSUInteger coinID;
@property (nonatomic) BBChartView* chartView;
@property (nonatomic) CoinChartType chartType;

- (instancetype)initWithCoin:(NSUInteger )coinID;
@end
