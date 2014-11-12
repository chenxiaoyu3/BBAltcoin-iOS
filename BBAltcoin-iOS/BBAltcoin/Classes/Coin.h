//
//  Coin.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/24.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Coin : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * name_zh;

@property (atomic) float buyPrice;
@property (atomic) float cellPrice;

-(NSString*) toString;
@end
