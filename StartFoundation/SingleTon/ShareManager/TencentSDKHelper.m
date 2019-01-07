//
//  TencentSDKHelper.m
//  iShanggang
//
//  Created by lijun on 2017/6/29.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "TencentSDKHelper.h"
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface TencentSDKHelper () <QQApiInterfaceDelegate>

@end

@implementation TencentSDKHelper

- (void)registerApp:(NSString *)appId withRedirectUri:(NSString *)redirectURI
{
    if(!self.tencentOAuth)
    {
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:nil];
        self.tencentOAuth.redirectURI = redirectURI;
    }
}

+ (BOOL)handleOpenURL:(NSURL *)url
{
    return ([TencentOAuth HandleOpenURL:url]
            || [QQApiInterface handleOpenURL:url delegate:[TencentSDKHelper sharedSDKHelper]]);
}

#pragma mark - SingleTon

+ (instancetype)sharedSDKHelper
{
    static TencentSDKHelper *sharedSDKHelperInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedSDKHelperInstance = [[self alloc] init];
    });
    return sharedSDKHelperInstance;
}

#pragma mark - TencentApiInterfaceDelegate

/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req
{
    if([self.shareDelegate respondsToSelector:@selector(onReq:)])
    {
        [self.shareDelegate onReq:req];
    }
}

/**
 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp
{
    if (resp.type == ESENDMESSAGETOQQRESPTYPE) {
        if ([resp.result isEqualToString:@"0"]) {
            [BONoticeBar defaultBar].noticeText = @"QQ分享成功";
//            [[ASGOCToRNConter defaultCenter] shareSuccess:@"QQ"];
        }else{
            [BONoticeBar defaultBar].noticeText = @"QQ分享失败";
//            [[ASGOCToRNConter defaultCenter] shareFail:@"QQ"];
        }
    }
}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response
{
    if([self.shareDelegate respondsToSelector:@selector(isOnlineResponse:)])
    {
        [self.shareDelegate isOnlineResponse:response];
    }
}


@end
