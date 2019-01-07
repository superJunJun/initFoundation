//
//  WKWebViewController.m
//  iShanggang
//
//  Created by lijun on 2018/11/8.
//  Copyright © 2018 aishanggang. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WKUserContentController.h>
#import <WebKit/WKScriptMessage.h>
#import <WebKit/WebKit.h>
#import "WebViewBottomView.h"

@interface WKWebViewController ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong)UIBarButtonItem *closeButtonItem;
@property (nonatomic, strong)WebViewBottomView *bottomView;
@property (nonatomic,copy)NSString *resultUrlStr;

@property (nonatomic, weak)id<WKNavigationDelegate> webDelegate;


@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.wkWebView];
   
   _url = [NSURL URLWithString:@"https://www.baidu.com"];
   NSURLRequest *request = [NSURLRequest requestWithURL:_url];
   [self.wkWebView loadRequest:request];
   
   [self.view addSubview:self.progressView];
    
   ///KVO-title
   [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
   
   ///KVO-estimatedProgress
   [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    self.navigationItem.leftBarButtonItem = self.closeButtonItem;
}

#pragma mark - get
- (WKWebView *)wkWebView
{
    if (!_wkWebView) {
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
//        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//        [userContentController addScriptMessageHandler:self name:@"yourRegisterHandle"];
//        config.userContentController = userContentController;
//        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _wkWebView = [WKWebView new];
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        _wkWebView.allowsBackForwardNavigationGestures = YES;//允许右滑手势返回上一页面(网页)
    }
    return _wkWebView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        CGFloat progressBarHeight = 3.0f;
        CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, 0, navigaitonBarBounds.size.width, progressBarHeight);

      _progressView = [[UIProgressView alloc] initWithFrame:barFrame];
      _progressView.backgroundColor = [UIColor clearColor];//背景色-若trackTintColor为clearColor,则显示背景颜色
      _progressView.progressTintColor = [UIColor colorWithRed:119.0/255 green:228.0/255 blue:115.0/255 alpha:1];//进度条颜色
      _progressView.trackTintColor = [UIColor clearColor];//进度条还未到达的线条颜色
      _progressView.progress = 0.3;
    }
   return _progressView;
}

-(UIBarButtonItem*)closeButtonItem {
    if (!_closeButtonItem) {
        
        UIButton* closeButton = [[UIButton alloc] init];
        [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [closeButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [closeButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [closeButton.titleLabel setFont:[BOAssistor defaultTextStringFontWithSize:15.0]];
        [closeButton sizeToFit];
        [closeButton addTarget:self action:@selector(closeItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _closeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
    return _closeButtonItem;
}

- (WebViewBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [WebViewBottomView new];
        [self.view addSubview:_bottomView];
        @weakify(self);
        _bottomView.btnBlcok = ^(NSString *type) {
            @strongify(self);
            if ([type isEqualToString:@"back"]) {
                if (self.wkWebView.canGoBack) {
                    [self.wkWebView goBack];
                }
            }else if ([type isEqualToString:@"forward"]) {
                if (self.wkWebView.canGoForward) {
                    [self.wkWebView goForward];
                }
            }
        };
    }
    return _bottomView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

}

#pragma mark - click
- (void)customBackItemClicked {
    if (self.wkWebView.canGoBack) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeItemClicked {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateBottomBar{
//    [self viewWillLayoutSubviews];
    
    UIButton *backBtn = self.bottomView.backBtn;
    UIButton *forwardBtn = self.bottomView.forwardBtn;
    
    backBtn.enabled = self.wkWebView.canGoBack;
    forwardBtn.enabled = self.wkWebView.canGoForward;
    
    if (self.wkWebView.canGoBack || self.wkWebView.canGoForward) {
        
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self.view.mas_bottomMargin);
        }];
        [_wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.bottomView.mas_top);
        }];
    }else {
        [_wkWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.view.mas_bottomMargin);
        }];
        
        [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
            make.top.mas_equalTo(self.view.mas_bottomMargin);
        }];
    }
}

#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else if ([keyPath isEqualToString:@"title"]) {
        if ([object isEqual:self.wkWebView] && self.navigationController) {
            self.title = self.wkWebView.title;
        }
    }
}

#pragma mark - web
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    if (webView != _wkWebView) {
        return;
    }
    NSString *requestString = navigationAction.request.URL.absoluteString;
    __strong typeof (_webDelegate)strongDelegate = _webDelegate;
    
    if ([requestString hasPrefix:@"alipay://"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
        decisionHandler(WKNavigationActionPolicyCancel);

    } else if ([strongDelegate respondsToSelector:@selector(webView:decidePolicyForNavigationAction:decisionHandler:)])
    {
        [strongDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
    [self updateBottomBar];
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}
#pragma mark -WKScriptMessageHandler 监控webView按钮点击事件
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    NSLog(@"==%@", message.body);
    NSString *functionName = message.body;
    if ([functionName isEqualToString:@"methodA"]) {
        
       } else if ([functionName isEqualToString:@"methodB"]) {
           
    }
}


#pragma mark -WKUIDelegate
//- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
//{
//  NSLog(@"--创建一个新的webView-createWebViewWithConfiguration");
//  return [[WKWebView alloc] init];
//}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
