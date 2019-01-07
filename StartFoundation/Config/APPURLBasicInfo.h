//
//  EnvironmentService.h
//  iShanggang
//
//  Created by  bxf on 2017/8/14.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EnvironmentType) {
    Environment_TEST = 1000,
    Environment_DEV,
    Environment_STAGE,
    Environment_RELEASE,
};

@interface APPURLBasicInfo : NSObject

@property (nonatomic, strong) NSString *isgBasicUrl;
@property (nonatomic, strong) NSString *chimaBasicUrl;
@property (nonatomic, strong) NSString *chimaBasicPicUrl;
@property (nonatomic, assign) EnvironmentType environmentType;

@property (nonatomic, strong) NSArray *basicUrlArr;

+ (instancetype)sharedInstance;
- (void)showChooseAPPBasicURLActionSheet;

@end
