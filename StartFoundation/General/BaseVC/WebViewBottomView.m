//
//  WebViewBottomView.m
//  StartFoundation
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 李君. All rights reserved.
//

#import "WebViewBottomView.h"

@implementation WebViewBottomView

- (instancetype )init {
    if (self = [super init]) {
        [self loadSubView];
    }
    return self;
}

- (void)loadSubView {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back_dis"] forState:UIControlStateDisabled];
    [backBtn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.enabled = NO;
    [self addSubview:backBtn];
    self.backBtn = backBtn;
    
    UIButton *forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forwardBtn setImage:[UIImage imageNamed:@"forward"] forState:UIControlStateNormal];
    [forwardBtn setImage:[UIImage imageNamed:@"forward_dis"] forState:UIControlStateDisabled];
    [forwardBtn addTarget:self action:@selector(forwardItemClick) forControlEvents:UIControlEventTouchUpInside];
    forwardBtn.enabled = NO;
    [self addSubview:forwardBtn];
    self.forwardBtn = forwardBtn;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
    [self.forwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(20);
    }];
}

- (void)backItemClick {
    self.btnBlcok(@"back");
}

- (void)forwardItemClick {
    self.btnBlcok(@"forward");
}

@end
