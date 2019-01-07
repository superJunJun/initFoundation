//
//  BOHUDManager.m
//  iShanggang
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 aishanggang. All rights reserved.
//

#import "BOHUDManager.h"
#import "MBProgressHUD.h"

static NSString *kLoadingMessage = @"加载中";
static NSInteger kDefaultShowTime = 2;

@interface BOHUDManager ()

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation BOHUDManager

+ (instancetype)defaultManager
{
    static BOHUDManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

#pragma mark - OverridePropertyMethod

- (MBProgressHUD *)progressHUD
{
    if(!_progressHUD)
    {
        UIWindow *mainWindow = [[UIApplication sharedApplication].delegate window];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:mainWindow animated:NO];
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        hud.backgroundView.color = [UIColor colorWithWhite:0 alpha:0.5];
        hud.removeFromSuperViewOnHide = YES;
        _progressHUD = hud;
    }
    return _progressHUD;
}


+ (void)showLoading {
    [self hideAlert];
  
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.userInteractionEnabled=YES;
    hud.label.text=NSLocalizedString(kLoadingMessage,nil);
    [hud showAnimated:YES];
}

+ (void)showLoading:(NSString *)title {
    [self hideAlert];
  
    if (title.length==0) {
        title=kLoadingMessage;
    }
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.label.text=NSLocalizedString(title,nil);
    [hud showAnimated:YES];
}

+ (void)showBriefAlert:(NSString *)alert {
    [self hideAlert];
    if (alert.length==0) {
        return;
    }
    
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.margin = 10.f;
    hud.mode = MBProgressHUDModeText;
    //HUD.yOffset = 200;
    hud.userInteractionEnabled=NO;
    hud.offset = CGPointMake(0, 200);
    hud.label.text=NSLocalizedString(alert,nil);
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kDefaultShowTime];
}

+ (void)showError:(NSString *)title {
    [self hideAlert];
    
    if (title.length==0) {
        return;
    }
    
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;

    UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    littleView.image = [UIImage imageNamed:@"error"];
    hud.customView = littleView;
    hud.label.text = title;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kDefaultShowTime];
}

+ (void)showSuccess:(NSString *)title {
    [self hideAlert];
    if (title.length==0) {
        return;
    }
    
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    littleView.image = [UIImage imageNamed:@"success"];
    hud.customView = littleView;
    hud.label.text = title;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kDefaultShowTime];
}

+ (void)showErrorNet
{
    [self hideAlert];
    
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    littleView.image = [UIImage imageNamed:@"success"];
    hud.customView = littleView;
    hud.label.text = @"网络链接失败,请重试";
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:kDefaultShowTime];
}

+ (void)hideAlert {
    MBProgressHUD *hud=[BOHUDManager defaultManager].progressHUD;
    [hud hideAnimated:NO afterDelay:0];
}

@end
