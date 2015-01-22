//
//  ChartViewController.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/22.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "ChartViewController.h"
#import "NavController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect frame = self.view.frame;
    self.chartView = [[BBChartView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-kNavigationBarHeight)];
    [self.view addSubview:self.chartView];
    
    self.title = [[DataCenter center] coinAbbrOfID:self.coinID];
    
    [[DataCenter center] addDataObserver:self];
    [[DataCenter center] requestChartDataOfCoin:self.coinID andType:ChartTime];
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
        Area* areadown = [[Area alloc] init];
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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
