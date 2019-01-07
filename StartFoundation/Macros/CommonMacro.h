//
//  CommonMacro.h
//  iShanggang
//
//  Created by lijun on 17/5/17.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h


//常用颜色
#define cCommonHeaderGrayColor   [UIColor colorWithHex:0xF8F8F8]
#define cCommonTextGrayColor   [UIColor colorWithHex:0x666666]
#define cCommonBlueColor          [UIColor colorWithHex:0x2f5cf7]
#define cCommonAlphaBlueColor     [[UIColor colorWithHex:0x3B82FF] colorWithAlphaComponent:.2]
#define cCommonLineColor         cCommonRGBColor(229,229,229,1)
#define cCommonRGBColor(red,Green,Blue,Alpha) [UIColor colorWithRed:red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]
//屏幕
#define KSCREEWIDTH [UIScreen mainScreen].bounds.size.width
#define KSCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define KSCREEWINDOW [[[UIApplication sharedApplication] delegate] window]
#define AdaptH(H) KSCREEWIDTH * H/375.0

//#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//#define kNavBarHeight 44.0
//#define kTopHeight (kStatusBarHeight + kNavBarHeight)
//#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kTabBarHeight (KIsiPhoneX ? 83 : 49)

//系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//app版本号
#define APPBundleShortVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//
#define isStrEmpty(_ref)  (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref)isEqualToString:@""]))

//客服电话
#define SERVICETEL @"400-688-8978"

#define sNetworkState        @"sNetworkState"

#endif /* CommonMacro_h */
