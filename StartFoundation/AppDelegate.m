//
//  AppDelegate.m
//  StartFoundation
//
//  Created by 李君 on 2019/1/3.
//  Copyright © 2019 李君. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "APPURLBasicInfo.h"

#import "AppDelegate+UMeng.h"
#import "AppDelegate+APPUpdate.h"
#import "AppDelegate+RegistRouters.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // MARK: -  注意现在测试的支付金额都是1--------------------------------
#ifdef DEBUG
    [APPURLBasicInfo sharedInstance].environmentType = Environment_TEST;
    [[APPURLBasicInfo sharedInstance] showChooseAPPBasicURLActionSheet];
#else
    [APPURLBasicInfo sharedInstance].environmentType = Environment_RELEASE;
#endif
    // 开屏广告
    [self setupLaunchAd];
    
    // IQKeyboardManager
    [IQKeyboardManager sharedManager].enableAutoToolbar              = NO;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside     = YES;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder   = NO;

    
#ifdef DEBUG
//    [BeeCloud setWillPrintLog:YES];
#else
#endif
    //初始化微信官方APP支付
    //此处的微信appid必须是在微信开放平台创建的移动应用的appid，且必须与在『BeeCloud控制台-》微信APP支付』配置的"应用APPID"一致，否则会出现『跳转到微信客户端后只显示一个确定按钮的现象』。
//    if (![BeeCloud initWeChatPay:sShareSDKWeChatAppId]) {
//        NSLog(@"BeeCloud 微信初始化失败");
//    }
    //引导页
//    [self setupIntroductoryPage];
    //友盟
    [self UMengConfigWithLaunchingWithOptions:launchOptions];
    //检查更新
    [self appUpdate];
    //注册路由
    [self registRouters];
    //注册 默认参数值
    [self setAPPUserDefault];
    
    return YES;
}

- (void)registRouters {
    [self registerRouteWithScheme:@"RouteOne"];
}


- (void)applicationWillResignActive:(UIApplication *)application {


}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
