//
//  AppDelegate.h
//  BBAltcoin-iOS
//
//  Created by ChenXiaoyu on 14-10-9.
//  Copyright (c) 2014年 ChenXiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoinOverallViewController.h"
#import "Coin.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIViewController* mainViewController;

@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;
//-(NSManagedObjectModel *)managedObjectModel;
//-(NSManagedObjectContext *)managedObjectContext;

-(void) saveContext;

@end

