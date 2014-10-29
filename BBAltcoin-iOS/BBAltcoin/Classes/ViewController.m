//
//  ViewController.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "ViewController.h"
#import "CoinCell.h"
#import "DataCenter.h"
#import "Macro.h"
#import "Utils.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.translucent = false;

    self.title = NSLocalizedString(@"BBCoin", nil);
    UIImageView* imageView =
    [[UIImageView alloc] initWithImage:[Utils imageWithImage:[UIImage imageNamed:@"bg_main_5.png"] scaledToSize:self.view.frame.size]];
    ;
    CGRect allCoinViewFrame = self.view.frame;
    allCoinViewFrame.origin.y = self.navigationController.navigationBar.frame.size.height;
    self.allCoinView = [[UIView alloc] initWithFrame:allCoinViewFrame];
    int lrMargin = 15, cellLMargin = 10, cellTopMargin = 10;
    int cellWidth = ((SCREEN_WIDTH - lrMargin*2) - cellLMargin* 2 * 4 ) / 4;
    int cellHeight = cellWidth / 1;
    
    int curRow = -1, curCol = 0;
    for (int iCoin = 0; iCoin < [[[DataCenter sharedInstance] coins] count]; ++iCoin) {
        if(iCoin % 4 == 0){
            curRow++;
            curCol = 0;
        }else{
            curCol++;
        }
        
        int begX = lrMargin + curCol * (cellLMargin*2 + cellWidth);
        int begY = curRow * (cellHeight+cellTopMargin);
        CoinCell * cell = [[CoinCell alloc] initWithFrame:CGRectMake(begX, begY, cellWidth, cellHeight)];
        cell.coinID = iCoin;
        [self.allCoinView addSubview:cell];
        
    }
    [self.view addSubview:imageView];
    [self.view addSubview:self.allCoinView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
