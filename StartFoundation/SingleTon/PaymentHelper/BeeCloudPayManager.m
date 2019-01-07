//
//  BeeCloudPayManager.m
//  iShanggang
//
//  Created by  bxf on 2017/6/29.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "BeeCloudPayManager.h"
#import "AsgRNTControlCenter.h"
#import "BeeCloud.h"

@interface BeeCloudPayManager()<BeeCloudDelegate>

@end

@implementation BeeCloudPayManager

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self commitInit];
    }
    return self;
}

+ (instancetype )payManager{
    static BeeCloudPayManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BeeCloudPayManager alloc] init];
    });
    return manager;
}

- (void)commitInit {
    [BeeCloud setBeeCloudDelegate:self];
}

- (void)initializeBeeCloudIDWithSource:(NSString *)source {
    if (!source || [source isEqualToString:@""]) {
        NSLog(@"爱上岗支付");

        NSString *BeeCloud_APPID = nil;
        NSString *BeeCloud_APPSecret = nil;
#ifdef DEBUG
        BeeCloud_APPID = @"c4849a69-f6f5-4b29-9fd9-eaebec361d7e";
        BeeCloud_APPSecret = @"8d48ff14-3ee8-4b8b-b8b6-a6ee840fd745";
        
        BeeCloud_APPID = @"a736fc62-5586-4c2e-8021-652297cbeb96";
        BeeCloud_APPSecret = @"8149cc8a-1347-4def-ae38-4ecbad5733d3";
        
        if(![BeeCloud initWithAppID:BeeCloud_APPID andAppSecret:BeeCloud_APPSecret sandbox:NO]){
            NSLog(@"BeeCloud 初始化失败");
        }else{
            NSLog(@"BeeCloud 初始化成功");
        }
#else
        BeeCloud_APPID = @"a736fc62-5586-4c2e-8021-652297cbeb96";
        BeeCloud_APPSecret = @"8149cc8a-1347-4def-ae38-4ecbad5733d3";
        if(![BeeCloud initWithAppID:BeeCloud_APPID andAppSecret:BeeCloud_APPSecret sandbox:NO]){
            NSLog(@"BeeCloud 初始化失败");
        }else{
            NSLog(@"BeeCloud 初始化成功");
        }
#endif
        
    } else if ([source isEqualToString:@"isg_chimamall"]) {
        NSLog(@"芝蚂城支付");
        
        NSString *BeeCloud_APPID = nil;
        NSString *BeeCloud_APPSecret = nil;

#ifdef DEBUG
        BeeCloud_APPID = @"87b24eba-9c14-4e0b-aab3-d6ceb84e21c6";
        BeeCloud_APPSecret = @"57353916-7f2e-4415-a170-59382b9ab91d";
        
        if(![BeeCloud initWithAppID:BeeCloud_APPID andAppSecret:BeeCloud_APPSecret sandbox:NO]){
            NSLog(@"BeeCloud 初始化失败");
        }else{
            NSLog(@"BeeCloud 初始化成功");
        }
#else
        BeeCloud_APPID = @"650b9a4b-89c8-484c-8cb2-690cc9062aaf";
        BeeCloud_APPSecret = @"53a4ac5b-96b3-4a85-8b33-c9c26f15fc50";
        
        if(![BeeCloud initWithAppID:BeeCloud_APPID andAppSecret:BeeCloud_APPSecret sandbox:NO]){
            NSLog(@"BeeCloud 初始化失败");
        }else{
            NSLog(@"BeeCloud 初始化成功");
        }
#endif
    }
}

#pragma mark - 微信、支付宝
- (void)doPay:(PayChannel)channel info:(NSDictionary *)billInfo {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    NSString *payTitle = billInfo[@"title"];
    /**
     按住键盘上的option键，点击参数名称，可以查看参数说明
     **/
    BCPayReq *payReq = [[BCPayReq alloc] init];
    /**
     *  支付渠道，PayChannelWxApp,PayChannelAliApp,PayChannelUnApp,PayChannelBaiduApp
     */
    payReq.channel = channel; //支付渠道
    if (channel == PayChannelAliApp) {
        payTitle = [self stringTrim:payTitle];
    }
    payReq.title = payTitle;//订单标题
    
    payReq.notify_url = billInfo[@"notify_url"];
    payReq.totalFee = billInfo[@"total_fee"];//订单价格; channel为BC_APP的时候最小值为100，即1元
    payReq.billNo = billInfo[@"bill_no"];//billInfo[@"bill_no"];//商户自定义订单号
    payReq.scheme = @"isg";//URL Scheme,在Info.plist中配置; 支付宝,银联必有参数
    payReq.billTimeOut = [billInfo[@"bill_timeout"] integerValue];//订单超时时间
//#ifdef DEBUG
//    payReq.viewController = [BOAssistor getCurrentNav]; //银联支付和Sandbox环境必填
//#else
//#endif
    payReq.cardType = 0; //0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
    [BeeCloud sendBCReq:payReq];
}

#pragma mark - BeeCloudDelegate
- (void)onBeeCloudResp:(BCBaseResp *)resp {
    
    switch (resp.type) {
        case BCObjsTypePayResp:
        {
            // 支付请求响应
            BCPayResp *tempResp = (BCPayResp *)resp;
            if (tempResp.resultCode == BCErrCodeSuccess) {
                BCPayReq *payReq = (BCPayReq *)resp.request;
                //百度钱包比较特殊需要用户用获取到的orderInfo，调用百度钱包SDK发起支付
                if (payReq.channel == PayChannelBaiduApp && ![BeeCloud getCurrentMode]) {
                    
                } else {
                    //微信、支付宝、银联支付成功
//                    [self showAlertView:resp.resultMsg];
                }
                if (self.resultBlock) {
                    self.resultBlock(@{@"result":@(1)});
                }
            } else if (tempResp.resultCode == BCErrCodeUserCancel) {
                //支付取消
                if (self.resultBlock) {
                    self.resultBlock(@{@"result":@(2)});
                }
//                [self showAlertView:[NSString stringWithFormat:@"%@",resp.resultMsg]];
            } else {
                //支付失败
                if (self.resultBlock) {
                    self.resultBlock(@{@"result":@(3)});
                }
//                [self showAlertView:[NSString stringWithFormat:@"%@",resp.resultMsg]];
            }
        }
            break;
        default:
        {
            if (resp.resultCode == 0) {
//                [self showAlertView:resp.resultMsg];
            } else {
//                [self showAlertView:[NSString stringWithFormat:@"%@",resp.resultMsg]];
            }
        }
            break;
    }
}

- (void)showPayAlert:(NSString *)msg {
    //1.弹出窗口
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    //1.1添加确定动作
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:sureAction];
    //2.弹出窗口
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (NSString *)stringTrim:(NSString *)sourceString
{
    NSArray *signStrings = @[@"#",@"%",@"&",@"+",@"@",@"$",@"¥"];
    for (NSString *string in signStrings) {
        sourceString = [sourceString stringByReplacingOccurrencesOfString:string withString:@"-"];
    }
    return sourceString;
}

@end
