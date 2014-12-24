//
//  Utils.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/29.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Utils : NSObject
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIView *)viewOfFrame:(CGRect)frame andColor:(UIColor *)color;
@end

#define UIColorFromHex()