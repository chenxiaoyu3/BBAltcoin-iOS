//
//  Coin.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/24.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import "Coin.h"


@implementation Coin

@dynamic id;
@dynamic name;
@dynamic name_zh;

@synthesize cellPrice;
@synthesize buyPrice;

-(NSString*) toString{
    return [NSString stringWithFormat:@"%d:%@,%@", self.id.intValue, self.name, self.name_zh];
}
@end
