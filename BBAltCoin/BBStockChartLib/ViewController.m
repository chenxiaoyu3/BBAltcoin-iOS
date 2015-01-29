//
//  ViewController.m
//  BBChart
//
//  Created by ChenXiaoyu on 15/1/4.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "ViewController.h"
#import "BBChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    view.backgroundColor = [UIColor redColor];
    
    view.layer.borderColor = [[UIColor blackColor] colorWithAlphaComponent:0.5].CGColor;
    view.layer.borderWidth = 3;
    [self.view addSubview:view];
    
    CALayer* grayLayer = [[CALayer alloc] init];
    grayLayer.frame = CGRectMake(10, 10, 50, 200);
    grayLayer.borderColor = [UIColor whiteColor].CGColor;
    grayLayer.borderWidth = 2;
    grayLayer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:1] CGColor];
    grayLayer.anchorPoint = CGPointMake(0, 1);
    [view.layer addSublayer:grayLayer];
    
    
    CABasicAnimation* ani = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    ani.fromValue = [NSNumber numberWithFloat:0];
    ani.toValue = [NSNumber numberWithFloat:1.0];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    ani.duration = 2;
    
//    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    pathAnimation.duration = 10.0;
//    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
//    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
//    [grayLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    [grayLayer addAnimation:ani forKey:nil];

    CGMutablePathRef path = CGPathCreateMutable();
    //将路径的起点定位到  （50  120）
    CGPathMoveToPoint(path,NULL,50.0,120.0);
    //下面5行添加5条直线的路径到path中
    CGPathAddLineToPoint(path, NULL, 60, 130);
    CGPathAddLineToPoint(path, NULL, 100, 140);
    CGPathAddLineToPoint(path, NULL, 80, 150);
    CGPathAddLineToPoint(path, NULL, 90, 160);
    CGPathAddLineToPoint(path, NULL, 100, 170);
    //下面四行添加四条曲线路径到path
    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    //以“position”为关键字 创建 实例
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置path属性
    [animation setPath:path];
    [animation setDuration:3.0];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //这句代码 表示 是否动画回到原位
    // [animation setAutoreverses:YES];
    CFRelease(path);
//    [self.block.layer addAnimation:animation forKey:NULL];
//    [grayLayer addAnimation:animation forKey:nil];
    
    BBChartView* chartView = [[BBChartView alloc] initWithFrame:CGRectMake(50, 100, 300, 400)];
    [self.view addSubview:chartView];
    
    
    CATextLayer* t = [BaseLayer layerOfText:[NSString stringWithFormat:@"%.1f", 4544.3] withFont:@"Helvetica-Bold" fontSize:18 andColor:[UIColor blueColor]];
    t.bounds = CGRectMake(50, 50, 50, 50);
    [self.view.layer addSublayer:t];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
