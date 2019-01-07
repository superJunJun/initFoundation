//
//  AppDelegate+UMeng.h
//  iShanggang
//
//  Created by  bxf on 2018/1/11.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "AppDelegate.h"
//友盟统计、推送
#import <UMPush/UMessage.h>
#import <UMAnalytics/MobClick.h>

@interface AppDelegate (UMeng)<UNUserNotificationCenterDelegate>

- (void)UMengConfigWithLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
