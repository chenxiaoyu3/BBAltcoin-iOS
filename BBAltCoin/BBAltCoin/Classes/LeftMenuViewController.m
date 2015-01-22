//
//  LeftMenuViewController.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "Masonry.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (UIButton*) menuButtonOfText:(NSString*)text{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.textColor = [Theme curTheme].textColor1;
    [btn setBackgroundImage:[Utils imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    return btn;
}
- (void)setupLayout{
    self.coinOverallBtn = [self menuButtonOfText:NSLocalizedString(@"CoinOverall", nil)];
    self.coinDetailBtn = [self menuButtonOfText:NSLocalizedString(@"CoinDetail", nil)];
    [self.view addSubview:self.coinDetailBtn];
    [self.view addSubview:self.coinOverallBtn];
    
    [self.coinOverallBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [self.coinDetailBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.coinOverallBtn);
        make.top.equalTo(self.coinOverallBtn.bottom);
        make.height.equalTo(@40);
    }];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupLayout];
    
    self.view.backgroundColor = [Theme curTheme].bgColor2;
    
    [self.coinOverallBtn addTarget:self action:@selector(onCoinOverallBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.coinDetailBtn addTarget:self action:@selector(onCoinDetailBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onCoinOverallBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(onCoinOverallBtnClicked)]) {
        [self.delegate onCoinOverallBtnClicked];
    }
}

-(void)onCoinDetailBtnClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(onCoinDetailBtnClicked)]) {
        [self.delegate onCoinDetailBtnClicked];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
