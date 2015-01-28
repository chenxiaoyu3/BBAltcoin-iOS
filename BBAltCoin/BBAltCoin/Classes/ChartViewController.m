//
//  ChartViewController.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/22.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "ChartViewController.h"
#import "NavController.h"
#import <Foundation/Foundation.h>

@interface ChartViewController ()

@end

@implementation ChartViewController

- (instancetype)initWithCoin:(NSUInteger )coinID{
    self = [super init];
    if (self) {
        self.coinID = coinID;
        ((NavController*)self.navigationController).supportedInterfaceOrientatoin  = UIInterfaceOrientationMaskLandscape;
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (UIBarButtonItem*)btnForChartType:(CoinChartType)type{

    NSString* ss = nil;
    switch (type) {
        case ChartDay:
            ss = NSLocalizedString(@"ChartDay", nil);
            break;
        case ChartMin:
            ss = NSLocalizedString(@"ChartMin", nil);
            break;
        case ChartHour:
            ss = NSLocalizedString(@"ChartTime", nil);
            break;
        default:
            break;
    }
    
    UIBarButtonItem* ret = [[UIBarButtonItem alloc] initWithTitle:ss style:UIBarButtonItemStylePlain target:self action:@selector(chartTypeSelected:)];
    ret.tag = type;
    [ret setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    return ret;
    
}

- (void)_initButtons{
    UIBarButtonItem* btnTime = [self btnForChartType:ChartHour];
    UIBarButtonItem* btnMin = [self btnForChartType:ChartMin];
    UIBarButtonItem* btnDay = [self btnForChartType:ChartDay];
    NSArray* array = [NSArray arrayWithObjects:btnTime, btnMin, btnDay, nil];
    self.navigationItem.rightBarButtonItems = array;
}

- (IBAction)chartTypeSelected:(id)sender{
    CoinChartType tt = (CoinChartType) ((UIBarButtonItem*)sender).tag;
    self.chartType = tt;
    [[DataCenter center] requestChartDataOfCoin:self.coinID andType:tt];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartView = [[BBChartView alloc] init];
    [self.view addSubview:self.chartView];
    
    self.title = [[DataCenter center] coinAbbrOfID:self.coinID];
    [self _initButtons];
    
    [self.chartView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.width.equalTo(self.view.width);
        make.height.equalTo(self.view.height);
    }];
    
    [[DataCenter center] addDataObserver:self];
    [[DataCenter center] requestChartDataOfCoin:self.coinID andType:ChartHour];
}

- (void)updateViewConstraints{
    [super updateViewConstraints];
}
- (void)viewWillDisappear:(BOOL)animated{
    [[DataCenter center] removeDataObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", nil) style: UIBarButtonItemStylePlain target:self action:@selector(Back)];
    [backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor],  NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
}
- (IBAction)Back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)chartDataRequestCompleted:(NSUInteger)coinID chartType:(CoinChartType)type withStatus:(int)st andData:(NSArray *)data{
    [self.chartView reset];
    if (st == 0) {
        Area* areaup = [[Area alloc] init];
        areaup.bottomAxis.labelProvider = self;
        Area* areadown = [[Area alloc] init];
        areadown.bottomAxis.labelProvider = self;
        BarSeries* bar = [[BarSeries alloc] init];
        StockSeries* stock = [[StockSeries alloc] init];
        [areaup addSeries:stock];
        [areadown addSeries:bar];
        for (NSArray* arr in data) {
            [bar addPoint:Float(arr[1])];
            [stock addPointOpen:Float(arr[2]) close:Float(arr[5]) low:Float(arr[4]) high:Float(arr[3])];
        }
        [self.chartView addArea:areaup];
        [self.chartView addArea:areadown];
        [self.chartView setHeighRatio:0.3 forArea:areadown];
        [self.chartView drawAnimated:YES];
    }

}



#pragma mark - AxisXDataProvider
- (NSString *)textForIdx:(NSUInteger)idx{
//    NSLog(@"idx:%d",idx);
    NSString* ret = nil;
    int v = (int)idx;
    NSDate* curDate = [NSDate date];
    
    NSDate* date = nil;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSDateComponents* dateComponents = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (v % 15 == 0) {
        switch (self.chartType) {
            case ChartDay:
                [dateComponents setDay:v-90];
                formatter.dateFormat = @"MM/dd";
                break;
            case ChartMin:
                [dateComponents setMinute:(v- 90) * 5];
                formatter.dateFormat = @"HH:mm";
                break;
            case ChartHour:
                [dateComponents setHour:v-90];
                formatter.dateFormat = @"MM/dd HH:00";
                break;
            default:
                break;
        }
        date = [calendar dateByAddingComponents:dateComponents toDate:curDate options:0];
        ret = [formatter stringFromDate:date];
    }
    
    return ret;

}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
