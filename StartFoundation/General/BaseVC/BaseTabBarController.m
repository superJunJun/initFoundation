//
//  BaseTabBarController.m
//  iShanggang
//
//  Created by lijun on 2017/4/20.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "BaseTabBarController.h"
#import "LoginViewController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customTabBarLoad];
//    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)customTabBarLoad
{
    UITabBar *tabBar = self.tabBar;
    tabBar.barStyle = UIBarStyleBlack;
    tabBar.translucent = NO;
    UIColor *tintColor = [UIColor whiteColor];
    tabBar.tintColor = tintColor;
    if([tabBar respondsToSelector:@selector(barTintColor)])
    {
        tabBar.barTintColor = tintColor;
    }
    //tabBar上的灰色线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEWIDTH, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [tabBar addSubview:lineView];
    
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    // 对item设置相应地图片
    item0.selectedImage = [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item0.image = [[UIImage imageNamed:@"tab_home_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item1.selectedImage = [[UIImage imageNamed:@"tab_order"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item1.image = [[UIImage imageNamed:@"tab_order_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item2.selectedImage = [[UIImage imageNamed:@"tab_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    item2.image = [[UIImage imageNamed:@"tab_mine_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [item0 setTitleTextAttributes:@{NSForegroundColorAttributeName :cCommonBlueColor} forState:UIControlStateSelected];
    [item1 setTitleTextAttributes:@{NSForegroundColorAttributeName :cCommonBlueColor} forState:UIControlStateSelected];
    [item2 setTitleTextAttributes:@{NSForegroundColorAttributeName :cCommonBlueColor} forState:UIControlStateSelected];
}

//#pragma mark - UITabBarControllerDelegate
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//
//    NSArray *vcArr =  viewController.childViewControllers;
//    if (vcArr.count > 0) {
//        UIViewController *vc = vcArr[0];
//        if ([vc isKindOfClass:[ZhiMaNavViewController class]]) {
//            UINavigationController *nav = tabBarController.selectedViewController;
//
//            if ([[UserInfoManager sharedUserInfo] isUserAccountEnable]) {
//
//                return YES;
//            } else {
//
//                LoginViewController *vc = [LoginViewController new];
//                [nav pushViewController:vc animated:YES];
//            }
//            return NO;
//        }
//    }
//
//    return YES;
//}


@end
