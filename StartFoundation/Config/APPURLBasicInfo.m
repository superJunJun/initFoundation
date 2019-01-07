//
//  EnvironmentService.m
//  iShanggang
//
//  Created by  bxf on 2017/8/14.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "APPURLBasicInfo.h"

@interface APPURLBasicInfo ()<UIActionSheetDelegate, UIAlertViewDelegate>

@end

@implementation APPURLBasicInfo

+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}

- (void)setEnvironmentType:(EnvironmentType)environmentType {
    switch (environmentType) {
            case Environment_TEST:
        {
            self.isgBasicUrl = @"http://zmallapidev.99zmall.com:93/api/";
            self.chimaBasicUrl = @"http://zmallapitest.99zmall.com:92/";
            self.chimaBasicPicUrl = @"http://inte.99zmall.com/static/img/";
        }
            break;
            case Environment_DEV:
        {
            self.isgBasicUrl = @"http://wxddev.99zmall.com:99/asg/";
            self.chimaBasicUrl = @"http://zmallapitest.99zmall.com:91/";
            self.chimaBasicPicUrl = @"http://inte.99zmall.com/static/img/";
        }
            break;
            case Environment_STAGE:
        {
            self.isgBasicUrl = @"http://106.14.174.210:8080/api/";
            self.chimaBasicUrl = @"http://zmallapitest.99zmall.com:92/";
            self.chimaBasicPicUrl = @"http://inte.99zmall.com/static/img/";
        }
            break;
            case Environment_RELEASE:
        {
            self.isgBasicUrl = @"http://asgapi.99zmall.com/asg/";
            self.chimaBasicUrl = @"http://zmallapi.99zmall.com/";
            self.chimaBasicPicUrl = @"http://zmcimg.99zmall.com/static/img/";
        }
            break;
        default:
        {
            self.isgBasicUrl = @"http://asgapi.99zmall.com/asg/";
            self.chimaBasicUrl = @"http://zmallapi.99zmall.com/";
            self.chimaBasicPicUrl = @"http://zmcimg.99zmall.com/static/img/";
        }
            break;
    }
}

- (NSArray *)basicUrlArr {
    return @[
             @{
                 @"name": @"测试",
                 @"type": @1000,
                 },
             @{
                 @"name": @"开发",
                 @"type": @1001,
                 },
             @{
                 @"name": @"预发布",
                 @"type": @1002,
                 },
             @{
                 @"name": @"生产",
                 @"type": @1003,
                 },
             ];
}

- (void)showChooseAPPBasicURLActionSheet {
    NSMutableArray *titleArr = [NSMutableArray array];
    for (NSDictionary *dic in self.basicUrlArr) {
        NSString *title = dic[@"name"];
        NSString *showTitle = [NSString stringWithFormat:@"%@",title];
        [titleArr addObject:showTitle];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请选择APP运行的环境" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:titleArr[0],titleArr[1],titleArr[2], titleArr[3], nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger type = [self.basicUrlArr[buttonIndex][@"type"] integerValue];
    self.environmentType = type;
}

@end
