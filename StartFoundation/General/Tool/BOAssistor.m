//
//  BOAssistor.m
//
//  常用的辅助功能
//

#import "BOAssistor.h"
#import "NSString+MD5Addition.h"
#import "UIColor+Hex.h"
#import <sys/utsname.h>

#define currentDeviceSystemVersion            [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation BOAssistor

+ (BOOL)resourceString:(NSString *)resStr evalueWithPredicateRegex:(NSString *)regex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:resStr];
}

+ (BOOL)phoneNumberIsValid:(NSString *)phoneNumber
{
    return phoneNumber.length == 11;
}

+ (BOOL)idCardIsValid:(NSString *)idCard {
    idCard = [self TrimmingWhiteSpaceAndNewLineByString:idCard];
    if (idCard.length == 15 || idCard.length == 18) {
        return YES;
    }
    return NO;
}

+ (BOOL)bankCardIsValid:(NSString *)bankCard {
    if (bankCard.length >= 16 && bankCard.length <= 21 ) {
        return YES;
    }
    return NO;
}

+ (BOOL)realNameIsValid:(NSString *)realName {
    realName = [self TrimmingWhiteSpaceAndNewLineByString:realName];
    if (realName.length == 0) {
        return NO;
    }
    NSRange range1 = [realName rangeOfString:@"·"];
    NSRange range2 = [realName rangeOfString:@"•"];
    if(range1.location != NSNotFound ||   // 中文 ·
       range2.location != NSNotFound )    // 英文 •
    {
        //一般中间带 `•`的名字长度不会超过15位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 15)
        {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+[·•][\u4e00-\u9fa5]+$" options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        NSUInteger count = [match numberOfRanges];
        return count == 1;
    }
    else
    {
        //一般正常的名字长度不会少于2位并且不超过8位，如果有那就设高一点
        if ([realName length] < 2 || [realName length] > 8) {
            return NO;
        }
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]+$" options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:realName options:0 range:NSMakeRange(0, [realName length])];
        NSUInteger count = [match numberOfRanges];
        return count == 1;
    }
}

+ (NSString *)TrimmingWhiteSpaceAndNewLineByString:(NSString *)string {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    
    NSScanner * scanner2 = [NSScanner scannerWithString:html];
    NSString * text2 = nil;
    while([scanner2 isAtEnd]==NO)
    {
        [scanner2 scanUpToString:@"&" intoString:nil];
        [scanner2 scanUpToString:@";" intoString:&text2];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@;",text2] withString:@""];
    }

    return html;
}


+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font
{
    return [string sizeWithAttributes:@{NSFontAttributeName:font}];
}

+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode
{
    if(string.length == 0)
    {
        return CGSizeZero;
    }
    
    CGSize limitedSize = CGSizeMake(width, MAXFLOAT);
    if([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)])
    {
        return [string boundingRectWithSize:limitedSize
                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName:font}
                                    context:nil].size;
    }
    else
    {
        return [string sizeWithFont:font constrainedToSize:limitedSize lineBreakMode:mode];
    }
}

#pragma mark - LocalProvideFont
+ (UIFont *)defaultTextStringFontWithSize:(CGFloat)fontSize
{
    if (currentDeviceSystemVersion >= 9.0) {
       return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    }else{
       return [UIFont systemFontOfSize:fontSize];
    }
}

+ (UIFont *)mediumTextStringFontWithSize:(CGFloat)fontSize {
    if (currentDeviceSystemVersion >= 9.0) {
        return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    }else{
        return  [UIFont fontWithName:@"Helvetica-Bold" size:15];
    }
}

//数据是否为空
+ (NSString *)stringWithNilOrNull:(id)str
{
    if (str == nil || str == [NSNull null] ) {
        return @"";
    }
    if ([str isKindOfClass:[NSString class]]) {
        if ([str isEqualToString:@"(null)"]) {
            return @"";
        }
    }
    return str;
}

+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc {
    if (phoneStr.length >= 10) {
        NSString *str2 = [[UIDevice currentDevice] systemVersion];
        if ([str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2" options:NSNumericSearch] == NSOrderedSame)
        {
            NSString* PhoneStr = [NSString stringWithFormat:@"telprompt://%@",phoneStr];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneStr] options:@{} completionHandler:^(BOOL success) {
                NSLog(@"phone success");
            }];
        }else {
            NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
            if (phoneStr.length == 10) {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
            }else {
                [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
                [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
            }
            NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
            // 设置popover指向的item
            alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
            // 添加按钮
            [alert addAction:[UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                NSLog(@"点击了呼叫按钮10.2下");
                NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
                if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                    UIApplication * app = [UIApplication sharedApplication];
                    if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                        [app openURL:[NSURL URLWithString:PhoneStr]];
                    }
                }
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消按钮");
            }]];
            [selfvc presentViewController:alert animated:YES completion:nil];
        }
    }
}

+ (void)timeChangeWithBtn:(UIButton *)button {
    
    //退出到后台时继续走计时器
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:@(1) forKey:@"isBeginCountDown"];
    [userDefault synchronize];
    
    __block int timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [button setTitle:@"重新发送" forState:UIControlStateNormal];
                button.titleLabel.font = [BOAssistor defaultTextStringFontWithSize:14];
                [button setTitleColor:[UIColor colorWithHex:0xd23023] forState:UIControlStateNormal];
                button.userInteractionEnabled = YES;
                
                [BOAssistor setDefaultCountDownValue];
            });
        }else {
            
            int second = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d",second];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:[NSString stringWithFormat:@"%@秒后可重新发送",strTime] forState:UIControlStateNormal];
                button.titleLabel.font = [BOAssistor defaultTextStringFontWithSize:12];
                button.userInteractionEnabled = NO;
                [button setTitleColor:[UIColor colorWithHex:0x666666] forState:UIControlStateNormal];
            });
            timeout--;
            
        }
    });
    dispatch_resume(timer);
    
}

+ (void)setDefaultCountDownValue {
    [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:@"isBeginCountDown"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UINavigationController *)getCurrentNav
{
    UITabBarController *tabbarVC = (UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController;;

//    UITabBarController *tabbarVC = (UITabBarController *)[[UIApplication sharedApplication] delegate].window.rootViewController;;
    UINavigationController *nav = (UINavigationController *)tabbarVC.selectedViewController;
    return nav;
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (NSString *)changeNull:(id)object {
    if ([self isNull:object]) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%@",object];
    }
}

//完整判断方法
+ (BOOL)isNull:(id)object
{
    // 判断是否为空串
    if ([object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    } else if (object==nil) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)getDeviceSystemName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
                                            encoding:NSUTF8StringEncoding];
    //simulator
    if ([platform isEqualToString:@"i386"])          return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])        return @"Simulator";
    
    //iPhone
    if ([platform isEqualToString:@"iPhone1,1"])     return @"IPhone_1G";
    if ([platform isEqualToString:@"iPhone1,2"])     return @"IPhone_3G";
    if ([platform isEqualToString:@"iPhone2,1"])     return @"IPhone_3GS";
    if ([platform isEqualToString:@"iPhone3,1"])     return @"IPhone_4";
    if ([platform isEqualToString:@"iPhone3,2"])     return @"IPhone_4";
    if ([platform isEqualToString:@"iPhone4,1"])     return @"IPhone_4s";
    if ([platform isEqualToString:@"iPhone5,1"])     return @"IPhone_5";
    if ([platform isEqualToString:@"iPhone5,2"])     return @"IPhone_5";
    if ([platform isEqualToString:@"iPhone5,3"])     return @"IPhone_5C";
    if ([platform isEqualToString:@"iPhone5,4"])     return @"IPhone_5C";
    if ([platform isEqualToString:@"iPhone6,1"])     return @"IPhone_5S";
    if ([platform isEqualToString:@"iPhone6,2"])     return @"IPhone_5S";
    if ([platform isEqualToString:@"iPhone7,1"])     return @"IPhone_6P";
    if ([platform isEqualToString:@"iPhone7,2"])     return @"IPhone_6";
    if ([platform isEqualToString:@"iPhone8,1"])     return @"IPhone_6s";
    if ([platform isEqualToString:@"iPhone8,2"])     return @"IPhone_6s_P";
    if ([platform isEqualToString:@"iPhone8,4"])     return @"IPhone_SE";
    if ([platform isEqualToString:@"iPhone9,1"])     return @"IPhone_7";
    if ([platform isEqualToString:@"iPhone9,3"])     return @"IPhone_7";
    if ([platform isEqualToString:@"iPhone9,2"])     return @"IPhone_7P";
    if ([platform isEqualToString:@"iPhone9,4"])     return @"IPIPhone_7P";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"IPhone_8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"IPhone_8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"IPhone_8P";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"IPhone_8P";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"IPhone_X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"IPhone_X";
    if ([platform isEqualToString:@"iPhone11,8"])    return @"iPhone_XR";
    if ([platform isEqualToString:@"iPhone11,2"])    return @"iPhone_XS";
    if ([platform isEqualToString:@"iPhone11,4"]
        || [platform isEqualToString:@"iPhone11,6"])  return @"iPhone_XS_Max";
    return @"Unknown";
    
    
}


@end
