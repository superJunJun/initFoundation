//
//  AppDelegate+APPUpdate.m
//  iShanggang
//
//  Created by  bxf on 2018/1/11.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "AppDelegate+APPUpdate.h"
#import "OpenPlatformAppRegInfo.h"
#import "IntroductoryPageHelper.h"
#import "XHLaunchAd.h"

@implementation AppDelegate (APPUpdate)

- (void)appUpdate {
//    NSDictionary *parmaDic = @{@"deviceType":@"ios",@"appVersion":APPBundleShortVersion};
//    [NetWorkEngine requestWithURL:APPUpdateURL sessionID:NO params:parmaDic completeBlock:^(NSDictionary *result) {
//        if ([result[@"status"] integerValue] == 0) {
//            NSDictionary *contentDic = result[@"contents"];
//            NSString *desc = contentDic[@"updateDesc"];
//            NSInteger updateType = [contentDic[@"type"] integerValue];
//            if (updateType == 0) {
//                // 普通更新
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:desc delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
////                alert.tag = 900;
////                [alert show];
//            }else if (updateType == 1) {
//                // 强制更新
////                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"更新提示" message:desc delegate:self cancelButtonTitle:nil otherButtonTitles:@"去更新", nil];
////                alert.tag = 901;
////                [alert show];
//            }
//        }
//    } failedBlock:^(NSError *error) {
//
//    }];
}

- (void)setupIntroductoryPage {
    
    BOOL isFirstLaunch = [[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstLaunch"] boolValue];
    if (!isFirstLaunch)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isFirstLaunch"];
        NSArray *images = @[@"splashScreen0", @"splashScreen1", @"splashScreen2"];
        [IntroductoryPageHelper showIntroductoryPageView:images];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 900){
        if (buttonIndex == 1) {
            NSString *appStoreLink = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@", ISGAPPLEID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
        }
    }else if (alertView.tag == 901) {
        if (buttonIndex == 0) {
            NSString *appStoreLink = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/id%@", ISGAPPLEID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appStoreLink]];
            exit(1);
        }
    }
}

- (void)setupLaunchAd
{
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    [XHLaunchAd setWaitDataDuration:3];
    
//    [NetWorkEngine requestWithURL:sServiceUrlLaunchAd sessionID:NO params:nil completeBlock:^(NSDictionary *result) {
//
//        if ([result[@"status"] integerValue] == 0) {
//            XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
//            imageAdconfiguration.imageNameOrURLString = result[@"contents"][@"imgUrl"];
//            imageAdconfiguration.openModel = result[@"contents"];
//            imageAdconfiguration.duration = 3;
//            [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//        }
//    } failedBlock:^(NSError *error) {
//
//    }];
}

#pragma mark - XHLaunchAdDelegate
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint
{
    NSLog(@"ad click");
    // 先执行跳过，然后跳转
    
    [XHLaunchAd removeAndAnimated:YES];
    
    NSString *url = openModel[@"url"];
    NSString *bannerId = openModel[@"id"];
    
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        NSString *routeUrl = [NSString stringWithFormat:@"RouteOne://push/ISGWebViewController?urlString=%@",url];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:routeUrl]];
        
//        [NetWorkEngine requestWithURL:sServiceUrlBannerClick sessionID:NO params:@{@"bannerId" : bannerId} completeBlock:^(NSDictionary *result) {
//            NSLog(@"点击量统计成功");
//        } failedBlock:^(NSError *error) {
//            NSLog(@"点击量统计失败");
//        }];
    }
}

@end
