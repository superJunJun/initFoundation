//
//  AppDelegate+APPUpdate.h
//  iShanggang
//
//  Created by  bxf on 2018/1/11.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (APPUpdate) <UIAlertViewDelegate>


/**
 APP更新
 */
- (void)appUpdate;

/**
 介绍页
 */
- (void)setupIntroductoryPage;

/**
 开屏广告
 */
- (void)setupLaunchAd;


/**
 选择baseUrl
 */
- (void)chooseBaseUrl;

@end
