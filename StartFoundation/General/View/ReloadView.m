//
//  ReloadView.m
//  iShanggang
//
//  Created by lijun on 2018/8/23.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "ReloadView.h"

@implementation ReloadView

- (instancetype )init{
    if (self = [super init]) {
        self.size = CGSizeMake(KSCREEWIDTH, 250);
        self.center = CGPointMake(KSCREEWIDTH / 2, KSCREENHEIGHT / 2);
        [self placeholderViewLoad];
    }
    return self;
}

- (void)placeholderViewLoad {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_empty"]];
    [imageView sizeToFit];
    imageView.xCenter = KSCREEWIDTH / 2.0;
    imageView.top = 10;
    [self addSubview:imageView];
    
//    [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kTabBarHeight (KIsiPhoneX ? 83 : 49)
    
    NSString *text1 = [NetWorkEngine networkConnectionIsAvailable]?@"没有数据":@"无法连接到网络";
    UILabel *label1 = [UILabel new];
    label1.text = text1;
    label1.font = [BOAssistor defaultTextStringFontWithSize:15.0];
    label1.textColor = [UIColor colorWithHex:0x999999];
    [label1 sizeToFit];
    label1.top = imageView.bottom + 20;
    label1.xCenter = imageView.xCenter;
    [self addSubview:label1];
    
    NSString *text2 = [NetWorkEngine networkConnectionIsAvailable]?@"别紧张，试试看刷新页面~":@"请检查网络设置或稍后再试";
    UILabel *label2 = [UILabel new];
    label2.text = text2;
    label2.font = [BOAssistor defaultTextStringFontWithSize:13.0];
    label2.textColor = [UIColor colorWithHex:0x999999];
    [label2 sizeToFit];
    label2.top = label1.bottom + 10;
    label2.xCenter = imageView.xCenter;
    [self addSubview:label2];
    
    UIButton *reloadBtn = [UIButton new];
    reloadBtn.titleLabel.font = [BOAssistor defaultTextStringFontWithSize:16];
    [reloadBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [reloadBtn setTitleColor:cCommonBlueColor forState:UIControlStateNormal];
    reloadBtn.size = CGSizeMake(80, 30);
    reloadBtn.top = label2.bottom + 20;
    reloadBtn.xCenter = imageView.xCenter;
    reloadBtn.layer.borderWidth = 1;
    reloadBtn.layer.borderColor = cCommonBlueColor.CGColor;
    [reloadBtn addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:reloadBtn];
}

- (void)reloadView {
    [self removeFromSuperview];
    self.refreshBlock();
}

@end
