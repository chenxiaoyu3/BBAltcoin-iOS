//
//  Theme.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/12/19.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Theme : UIColor

-(UIColor*) themeColor1;
-(UIColor*) themeColor2;
-(UIColor*) textColor1;
-(UIColor*) textcolor2;

+(Theme*) curTheme;
@end
