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

DataCenter* dataCenter;
@implementation DataCenter

-(id) init{
    if(self = [super init]){
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
    for (Coin *c in self.coins) {
        NSLog(@"%@",[c toString]);
    }
    self.coinNum = self.coins.count;
}
-(NSString*) coinAbbrOfID:(int)coinID{
    return [[self.coins objectAtIndex:coinID] name];
}
-(NSString*) coinNameOfID:(int)coinID{
    return [[self.coins objectAtIndex:coinID] name_zh];
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
