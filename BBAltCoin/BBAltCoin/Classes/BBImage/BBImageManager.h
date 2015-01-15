//
//  BBImage.h
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BBImageManager : NSObject

-(void)requestLOGO:(NSString*)coin
           success:(void(^) (NSString* coin, UIImage* image))success;

+(BBImageManager*) manager;
@end
