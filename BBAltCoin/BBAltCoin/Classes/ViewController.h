//
//  ViewController.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSArray* _constraintsArray;
}

@property (nonatomic, strong) UIView* coinCellsContainer;
@property (nonatomic, strong) NSMutableArray* coinCells;
@end

