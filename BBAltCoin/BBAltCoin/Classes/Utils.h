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

#define UIColorFromHex(hex) \
[UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 \
                green:((float)((hex & 0x00FF00) >> 8)) / 255.0 \
                 blue:((float)((hex & 0x0000FF) )) / 255.0 \
                alpha:1.0]

#define Float(obj) (((NSNumber*)(obj)).floatValue)