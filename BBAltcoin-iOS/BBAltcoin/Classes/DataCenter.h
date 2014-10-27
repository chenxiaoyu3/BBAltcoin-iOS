//
//  DataCenter.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/27.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCenter : NSObject

@property (nonatomic, strong) NSArray* coins;


+(DataCenter*) sharedInstance;
+(void) firstLaunchAction;
@end
