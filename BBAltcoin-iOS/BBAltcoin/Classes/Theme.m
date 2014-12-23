//
//  Theme.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/19.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "Theme.h"

@implementation Theme

-(UIColor *)themeColor1{
    return [UIColor colorWithRed:0.122 green:0.133 blue:0.161 alpha:1];
}
- (UIColor *)themeColor2{
    return [UIColor colorWithRed:0.157 green:0.184 blue:0.216 alpha:1] /*#282f37*/;
}
- (UIColor *)textColor1{
    return [UIColor whiteColor];
}
- (UIColor *)textcolor2{
    return [UIColor colorWithWhite:0.8 alpha:1];
}
+(Theme *)curTheme{
    return [[Theme alloc] init];
}

@end
