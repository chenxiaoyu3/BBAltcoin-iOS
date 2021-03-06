
//
//  MainViewController.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.coinDetailViewController = [[CoinDetailViewController alloc] init];
        self.coinOverallViewController = [[CoinOverallViewController alloc] init];
        
        self.topViewController = self.coinOverallViewController;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.anchorRightRevealAmount = 170;
    self.leftMenuViewController = [[LeftMenuViewController alloc] init];;
    self.underLeftViewController = self.leftMenuViewController;
    
    [self.view addGestureRecognizer:self.panGesture];
    self.leftMenuViewController.delegate = self;
    self.title = NSLocalizedString(@"BBAltcoin", nil);
    
    UIBarButtonItem *menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_list"] style:UIBarButtonItemStylePlain target:self action:@selector(barLeftItemClicked:)];

    self.navigationItem.leftBarButtonItem = menuBtn;

    self.coinOverallViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)barLeftItemClicked:(id)sender{

    [self anchorTopViewToRightAnimated:YES];
}
#pragma mark MenuDelegate
- (void)onCoinOverallBtnClicked{
    self.topViewController = self.coinOverallViewController;
    [self resetTopViewAnimated:YES];
}
- (void)onCoinDetailBtnClicked{
    self.topViewController = self.coinDetailViewController;
    [self resetTopViewAnimated:YES];
}

#pragma mark - CoinOverallViewControllerDelegate
- (void)onCoinCellTaped:(NSUInteger)coinID{
    self.topViewController = self.coinDetailViewController;
    self.coinDetailViewController.selectedCoinID = coinID;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
