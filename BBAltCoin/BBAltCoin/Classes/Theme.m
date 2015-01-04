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

- (UIColor *)bgColor1{
    return UIColorFromHex(0x1F2229);
}
- (UIColor *)bgColor2{
    return UIColorFromHex(0x282f37);
}
- (UIColor *)bgColor3{
    return UIColorFromHex(0x39434f);
}

- (UIColor *)greenForText1{
    return UIColorFromHex(0x42902e);
}

- (UIColor *)greenForNumber{
    return UIColorFromHex(0x46e940);
}
-(UIColor *)redForNumber{
    return UIColorFromHex(0xdc323b);
}
- (UIColor *)redForText1{
    return UIColorFromHex(0xbb221f);
}
- (UIColor *)debugColor1{
    return [UIColor redColor];
}
+(Theme *)curTheme{
    return [[Theme alloc] init];
}

@end
