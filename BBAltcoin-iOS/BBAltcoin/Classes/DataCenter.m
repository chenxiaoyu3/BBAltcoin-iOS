//
//  DataCenter.m
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14/10/27.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataCenter.h"
#import "Macro.h"
#import "AFNetworking.h"

DataCenter* dataCenter;
NSString* const SERVER_URL = @"http://ggcoin.sinaapp.com/API";
@implementation DataCenter

-(id) init{
    if(self = [super init]){
        _delegates = [[NSMutableArray alloc] init];
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(scheduleAction) userInfo:nil repeats:YES];
        [self initData];
    }
    return self;
}


-(void) initData{
    NSManagedObjectContext *context = [AppDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Coin" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.coins = [context executeFetchRequest:fetchRequest error:&error];
    
    self.coinsDict = [[NSMutableDictionary alloc] init];
    for (Coin *c in self.coins) {
        self.coinsDict[c.name] = c;
    }
    self.coinNum = self.coins.count;
    
}
-(NSString*) coinAbbrOfID:(NSUInteger)coinID{
    return [[self.coins objectAtIndex:coinID] name];
}
-(NSString*) coinNameOfID:(int)coinID{
    return [[self.coins objectAtIndex:coinID] name_zh];
}
-(Coin *)coinOfID:(int)coinID{
    return (Coin*)_coins[coinID];
}


- (void) requestPrice{
    
    NSMutableURLRequest* req = [[NSMutableURLRequest alloc] initWithURL:
                                [NSURL URLWithString:[NSString stringWithFormat:@"%@/price/buy", SERVER_URL]]];
    [req setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    AFHTTPRequestOperation* op = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* prices = (NSDictionary*)responseObject;
        [prices enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            ((Coin*)self.coinsDict[key]).buyPrice = ((NSNumber*)obj).floatValue;
        }];
        for (id<DataCenterDelegate> observer in _delegates){
            if ([observer respondsToSelector:@selector(priceRequestCompletedWithStatus:)]) {
                [observer priceRequestCompletedWithStatus:0];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Request price error %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

-(void)addDataObserver:(id)delegate{
    if (_delegates.count == 0) {
        [_timer setFireDate:[NSDate distantPast]];
    }
    if( ![_delegates containsObject:delegate] ){
        [_delegates addObject:delegate];
    }
    
}
-(void)removeDataObserver:(id)delegate{
    [_delegates removeObject:delegate];
    if (_delegates.count == 0) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

-(void)scheduleAction{
    [self requestPrice];
}

+(void) firstLaunchAction {
    NSManagedObjectContext* context = [AppDelegate managedObjectContext];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"coins" ofType:@"json"]];
    NSError* err = nil;
    NSArray* coins = (NSArray*)[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    
    int i = 0;
    for( NSDictionary* cur in coins){
        Coin* c = [NSEntityDescription insertNewObjectForEntityForName:@"Coin" inManagedObjectContext:context];
        c.id = [NSNumber numberWithInt:i++];
        c.name = [cur objectForKey:@"en"];
        c.name_zh = [cur objectForKey:@"zh"];
        NSLog(@"%@",[c toString]);
        [context save:&err];
    }
   
}

+(DataCenter*) center{
    if (!dataCenter) {
        dataCenter = [[DataCenter alloc] init];
    }
    return dataCenter;
}
@end
