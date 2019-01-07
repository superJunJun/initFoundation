//
//  IntroductoryPageHelper.m
//  iShanggang
//
//  Created by  bxf on 2018/1/10.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "IntroductoryPageHelper.h"
#import "IntroductoryPageView.h"

@interface IntroductoryPageHelper()

@property (nonatomic) UIWindow *rootWindow;
@property (nonatomic, strong) IntroductoryPageView *curIntroductoryPagesView;

@end

@implementation IntroductoryPageHelper

+ (instancetype)shareInstance
{
    static IntroductoryPageHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[IntroductoryPageHelper alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(void)showIntroductoryPageView:(NSArray *)imageArray
{
    if (![IntroductoryPageHelper shareInstance].curIntroductoryPagesView) {
        [IntroductoryPageHelper shareInstance].curIntroductoryPagesView = [[IntroductoryPageView alloc] initPagesViewWithFrame:CGRectMake(0, 0, KSCREEWIDTH, KSCREENHEIGHT) Images:imageArray];
    }
    
    [IntroductoryPageHelper shareInstance].rootWindow = [[[[UIApplication sharedApplication] delegate] window] rootViewController].view;
//    [IntroductoryPageHelper shareInstance].rootWindow = [UIApplication sharedApplication].keyWindow;
    [[IntroductoryPageHelper shareInstance].rootWindow addSubview:[IntroductoryPageHelper shareInstance].curIntroductoryPagesView];
}

@end
