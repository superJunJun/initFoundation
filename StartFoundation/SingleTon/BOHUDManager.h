//
//  BOHUDManager.h
//  iShanggang
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOHUDManager : NSObject


/**
 default 提示title : 加载中
 */
+ (void)showLoading;

/**
 @param title 提示title
 */
+ (void)showLoading:(NSString *)title;

/**
 @param alert 简短提示
 */
+ (void)showBriefAlert:(NSString *)alert;

/**
 失败icon加提示语
 @param title 提示语
 */
+ (void)showError:(NSString *)title;

/**
 成功icon加提示语
 @param title 提示语
 */
+ (void)showSuccess:(NSString *)title;

/**
 网络失败icon加提示语 default 提示title : 网络链接失败,请重试
 */
+ (void)showErrorNet;

/**
 hide loading
 */
+ (void)hideAlert;

@end
