//
//  Utils.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/29.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIView *)viewOfFrame:(CGRect)frame andColor:(UIColor *)color{
    UIView* ret = [[UIView alloc] initWithFrame:frame];
    ret.backgroundColor = color;
    return ret;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
