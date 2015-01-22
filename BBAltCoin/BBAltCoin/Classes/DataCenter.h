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

typedef enum {
    ChartTime, ChartMin, ChartDay
} CoinChartType;

@protocol DataCenterDelegate <NSObject>

@optional
-(void)priceRequestCompletedWithStatus:(int)st;
-(void)coinDetailRequestCompletedWithStatus:(int)st;
-(void)chartDataRequestCompleted:(NSUInteger)coinID
                       chartType:(CoinChartType)type
                      withStatus:(int)st
                         andData:(NSArray*)data;
@end

@interface DataCenter : NSObject{
    NSMutableArray* _delegates;
}

@property (nonatomic, strong) NSArray* coins;
@property (nonatomic, strong) NSMutableDictionary* coinsDict;
@property (nonatomic) NSUInteger coinNum;
@property (nonatomic, strong) NSTimer* timer;

//@property (nonatomic, strong) NSDate* lastPriceRequestDate;
//@property (nonatomic, strong) NSDate* lastDetaiRequestDate;

+(DataCenter*) center;
+(void) firstLaunchAction;

-(NSString*) coinNameOfID:(NSUInteger)coinID;
-(NSString*) coinAbbrOfID:(NSUInteger)coinID;
-(Coin*) coinOfID:(NSUInteger)coinID;

-(void)requestPrice;
-(void)requestCoinDetail;
-(void)requestChartDataOfCoin:(NSUInteger)coinID andType:(CoinChartType)type;

-(void)addDataObserver:(id)delegate;
-(void)removeDataObserver:(id)delegate;

@end

