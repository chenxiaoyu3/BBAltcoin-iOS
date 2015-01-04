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
-(UIColor*) bgColor1;
-(UIColor*) bgColor2;
-(UIColor*) bgColor3;

-(UIColor*) greenForText1;
-(UIColor*) greenForNumber;
-(UIColor*) redForText1;
-(UIColor*) redForNumber;

-(UIColor*) debugColor1;
+(Theme*) curTheme;
@end
