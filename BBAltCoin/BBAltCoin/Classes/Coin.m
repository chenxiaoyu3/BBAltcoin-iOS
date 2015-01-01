//
//  Coin.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/24.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "Coin.h"

@implementation OrderItem

+(instancetype)objFromDictionary:(NSDictionary *)dic{
    OrderItem* ret = [[OrderItem alloc] init];
    ret.price = [((NSNumber*)dic[@"price"]) floatValue];
    ret.amt = [((NSNumber*)dic[@"amount"]) floatValue];
    return ret;
}

@end

@implementation TradeItem

+(instancetype)objFromDictionary:(NSDictionary *)dic{
    TradeItem* ret = [[TradeItem alloc] init];
    ret.price = [((NSNumber*)dic[@"price"]) floatValue];
    ret.vol = [((NSNumber*)dic[@"volume"]) floatValue];
    return ret;
}

@end

@implementation CoinDetail

+ (instancetype)objFromDictionary:(NSDictionary *)dic{
    CoinDetail* ret = [[CoinDetail alloc] init];
    NSArray* buy = dic[@"buyOrder"];
    ret.buyOrder = [NSMutableArray arrayWithCapacity:buy.count];
    ret.sellOrder =[NSMutableArray arrayWithCapacity:buy.count];
    ret.trade = [NSMutableArray array];
    [buy enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [ret.buyOrder addObject:[OrderItem objFromDictionary:obj]];
    }];
    [dic[@"sellOrder"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [ret.sellOrder addObject:[OrderItem objFromDictionary:obj] ];
    }];

    NSArray* trade = dic[@"trade"];
    [trade enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [ret.trade addObject:[TradeItem objFromDictionary:obj]];
    }];
    return ret;
}
@end



@implementation Coin

@dynamic id;
@dynamic name;
@dynamic name_zh;

@synthesize detail = _detail;
@synthesize buyPrice;
@synthesize sellPrice;
@synthesize price = _price;


-(NSString*) toString{
    return [NSString stringWithFormat:@"%d:%@,%@", self.id.intValue, self.name, self.name_zh];
}

-(float) price{
    return (self.buyPrice + self.sellPrice) / 2.0;
}
- (void)setDetail:(CoinDetail *)detail{
    _detail = detail;
    self.buyPrice = ((OrderItem*)detail.buyOrder[0]).price;
    self.sellPrice = ((OrderItem*)detail.sellOrder[0]).price;
}

//- (float)buyPrice{
//    // TODO: what if the server's respond orderList is empty?
//    if (self.detail != nil) {
//        return ((OrderItem*)self.detail.buyOrder.firstObject).price;
//    }else{
//        return 0;
//    }
//}
//- (float)sellPrice{
//    if (self.detail != nil) {
//        return ((OrderItem*)self.detail.sellOrder.firstObject).price;
//    }else{
//        return 0;
//    }
//}
@end
