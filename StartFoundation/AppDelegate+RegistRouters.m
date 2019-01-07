//
//  AppDelegate+RegistRouters.m
//  iShanggang
//
//  Created by lijun on 2018/5/10.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import "AppDelegate+RegistRouters.h"
#import <JLRoutes.h>
#import <objc/runtime.h>

@implementation AppDelegate (RegistRouters)

- (void)registerRouteWithScheme:(NSString *)scheme{
    //RouteOne://push/FirstNextViewController
    [[JLRoutes routesForScheme:scheme] addRoute:@"/:push/:controller"handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSString *vcName = parameters[@"controller"];
        NSString *showStyle = parameters[@"push"];

        Class class = NSClassFromString(vcName);
        
        UIViewController *nextVC = [[class alloc] init];

        if ([vcName isEqualToString:@"ISGWebViewController"]) {
            NSString *urlStr = parameters[@"webUrl"];
            [nextVC setValue:urlStr forKey:@"urlString"];
        }else {
            [self paramToVc:nextVC param:parameters];
        }
        
        UIViewController *currentVc = [self currentViewController];
        if ([showStyle isEqualToString:@"push"]) {
            [currentVc.navigationController pushViewController:nextVC animated:YES];
        }else if ([showStyle isEqualToString:@"present"]) {
            [currentVc presentViewController:nextVC animated:YES completion:nil];
        }
        return YES;
    }];
}
//确定是哪个viewcontroller
-(UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = self.window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}
//传参数
-(void)paramToVc:(UIViewController *)v param:(NSDictionary<NSString *,NSString *> *)parameters{
    //        runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}

- (void)setAPPUserDefault {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (![userDefault objectForKey:@"currentCity"]) {
        [userDefault setObject:@"上海市" forKey:@"currentCity"];
        [userDefault setObject:@"上海" forKey:@"currentProvince"];
        [userDefault setObject:@"黄浦区" forKey:@"area"];
        [userDefault setObject:@(31.166335) forKey:@"currentlatitude"];
        [userDefault setObject:@(121.398001) forKey:@"currentlongitude"];
        [userDefault synchronize];
    }
}

@end
