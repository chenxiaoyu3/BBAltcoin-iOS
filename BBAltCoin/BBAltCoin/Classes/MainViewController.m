
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
        
        self.topViewController = self.coinDetailViewController;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.anchorRightRevealAmount = 180;
    self.leftMenuViewController = [[LeftMenuViewController alloc] init];;
    self.underLeftViewController = self.leftMenuViewController;
    
    [self.view addGestureRecognizer:self.panGesture];
    self.leftMenuViewController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
