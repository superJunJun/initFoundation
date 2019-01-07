//
//  TencentSDKHelper.h
//  iShanggang
//
//  Created by lijun on 2017/6/29.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TencentOAuth, APIResponse, QQBaseReq, QQBaseResp;

@protocol TencentSDKShareDelegate <NSObject>
@optional

//处理来至QQ的请求
- (void)onReq:(QQBaseReq *)req;

//处理来至QQ的响应
- (void)onResp:(QQBaseResp *)resp;

//处理QQ在线状态的回调
- (void)isOnlineResponse:(NSDictionary *)response;

@end

@interface TencentSDKHelper : NSObject

@property (strong, nonatomic) TencentOAuth *tencentOAuth;

@property (assign, nonatomic) id<TencentSDKShareDelegate> shareDelegate;

- (void)registerApp:(NSString *)appId withRedirectUri:(NSString *)redirectURI;
+ (instancetype)sharedSDKHelper;
+ (BOOL)handleOpenURL:(NSURL *)url;


@end
