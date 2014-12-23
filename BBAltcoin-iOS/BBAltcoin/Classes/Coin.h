//
//  Coin.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/24.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OrderItem : NSObject
@property (nonatomic) float price;
@property (nonatomic) float amt;
+(instancetype) objFromDictionary: (NSDictionary*) dic;
@end


@interface TradeItem : NSObject
@property (nonatomic) float price;
@property (nonatomic) float vol;
+(instancetype) objFromDictionary: (NSDictionary*) dic;
@end


@interface CoinDetail : NSObject
@property (atomic, strong) NSMutableArray* buyOrder;
@property (atomic, strong) NSMutableArray* sellOrder;
@property (atomic, strong) NSMutableArray* trade;
+(instancetype) objFromDictionary:(NSDictionary*)dic;
@end




@interface Coin : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * name_zh;

@property (atomic, strong) CoinDetail* detail;
@property (atomic) float buyPrice;
@property (atomic) float sellPrice;

-(NSString*) toString;
//-(float) buyPrice;
//-(float) sellPrice;

@end


