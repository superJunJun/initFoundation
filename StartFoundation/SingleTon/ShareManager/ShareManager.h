//
//  ShareManager.h
//  iShanggang
//
//  Created by lijun on 2017/7/4.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import "ISG_ShareInfo.h"
#import <MessageUI/MessageUI.h>

typedef NS_ENUM(NSInteger, ISGShareType) {
    ISGShareTypeWXFriend,
    ISGShareTypeWXFriendCircle,
    ISGShareTypeQQ,
    ISGShareTypeQQZone,
    ISGShareTypeSMS
};

@interface ShareManager : NSObject <MFMessageComposeViewControllerDelegate>
{
    UIViewController *_viewC;
}

+ (instancetype)shareManager;
- (void)shareImageToWeChat:(NSInteger )type withInfo:(ISG_ShareInfo *)shareInfo;
- (void)shareImageToQQ:(NSInteger )type withInfo:(ISG_ShareInfo *)shareInfo;
- (void)smsShareWithViewControll:(UIViewController *)viewC smsBody:(NSString *)body;


@end
