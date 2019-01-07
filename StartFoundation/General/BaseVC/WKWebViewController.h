//
//  WKWebViewController.h
//  iShanggang
//
//  Created by lijun on 2018/11/8.
//  Copyright © 2018 aishanggang. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WKWebView.h>

@interface WKWebViewController : BaseViewController

@property (nonatomic, copy)NSURL* url;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, copy) NSDictionary *brandDic;

@end
