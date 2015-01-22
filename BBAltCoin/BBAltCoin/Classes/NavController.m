//
//  NavController.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/22.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "NavController.h"

@interface NavController ()

@end

@implementation NavController

- (instancetype)init{
    self = [super init];
    if (self) {
        _supportedInterfaceOrientatoin = UIInterfaceOrientationMaskLandscape;
        _preferredOrientation = UIInterfaceOrientationLandscapeLeft;
    }
    return self;
}
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _supportedInterfaceOrientatoin = UIInterfaceOrientationMaskLandscape;
        _preferredOrientation = UIInterfaceOrientationLandscapeLeft;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations{
    return _supportedInterfaceOrientatoin;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return _preferredOrientation;
}

- (BOOL)shouldAutorotate{
    return YES;
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
