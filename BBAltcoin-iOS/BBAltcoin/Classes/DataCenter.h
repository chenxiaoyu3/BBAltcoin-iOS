//
//  DataCenter.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/27.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Coin.h"


@protocol DataCenterDelegate <NSObject>

@optional
-(void)priceRequestCompletedWithStatus:(int)st;

@end

@interface DataCenter : NSObject{
    NSMutableArray* _delegates;
}

@property (nonatomic, strong) NSArray* coins;
@property (nonatomic, strong) NSMutableDictionary* coinsDict;
@property (nonatomic) NSUInteger coinNum;
@property (nonatomic, strong) NSTimer* timer;

+(DataCenter*) center;
+(void) firstLaunchAction;

-(NSString*) coinNameOfID:(NSUInteger)coinID;
-(NSString*) coinAbbrOfID:(NSUInteger)coinID;
-(Coin*) coinOfID:(NSUInteger)coinID;

-(void)requestPrice;

-(void)addDataObserver:(id)delegate;
-(void)removeDataObserver:(id)delegate;

@end
