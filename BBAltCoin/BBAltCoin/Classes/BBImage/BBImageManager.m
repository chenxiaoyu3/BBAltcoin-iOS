//
//  BBImage.m
//  BBAltcoin
//
//  Created by ChenXiaoyu on 15/1/15.
//  Copyright (c) 2015年 ChenXiaoyu. All rights reserved.
//

#import "BBImageManager.h"

BBImageManager* instance;
NSString* URL_LOGO = @"http://rs.btc38.com/statics/images/coin_logos/%@_logo.png";
@implementation BBImageManager

- (void)requestLOGO:(NSString *)coin success:(void (^)(NSString *, UIImage *))success{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    UIImage * imageFromFile = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png", path, coin]];
    if (imageFromFile == nil) {
//        NSLog(@"Web request %@", coin);
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:URL_LOGO, coin]];
        AFHTTPRequestOperation* op = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
        op.responseSerializer = [AFImageResponseSerializer serializer];
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            UIImage* image = responseObject;
            success(coin, image);
            // save to file
            [UIImagePNGRepresentation(image) writeToFile:[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", coin]] options:NSAtomicWrite error:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Request LOGO Failed: %@, \n %@", coin, error);
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }else{
        success(coin, imageFromFile);
    }
}



+ (BBImageManager *)manager{
    if (instance == nil) {
        instance = [[BBImageManager alloc] init];
    }
    return instance;
}

@end
