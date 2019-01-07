//
//  BOAssistor.h
//
//  常用的辅助功能
//

#import <UIKit/UIKit.h>

@interface BOAssistor : NSObject

//格式有效性验证
+ (BOOL)phoneNumberIsValid:(NSString *)phoneNumber;
+ (BOOL)idCardIsValid:(NSString *)idCard;
+ (BOOL)bankCardIsValid:(NSString *)bankCard;
/**
 判断是否是有效的中文名
 
 @param realName 名字
 @return 如果是在如下规则下符合的中文名则返回`YES`，否则返回`NO`
 限制规则：
 1. 首先是名字要大于2个汉字，小于8个汉字
 2. 如果是中间带`{•|·}`的名字，则限制长度15位（新疆人的名字有15位左右的，之前公司实名认证就遇到过），如果有更长的，请自行修改长度限制
 3. 如果是不带小点的正常名字，限制长度为8位，若果觉得不适，请自行修改位数限制
 *PS: `•`或`·`具体是那个点具体处理需要注意*
 */
+ (BOOL)realNameIsValid:(NSString *)realName;

+ (NSString *)stringWithNilOrNull:(id)str;

//移除开头和结尾的空格和换行
+ (NSString *)TrimmingWhiteSpaceAndNewLineByString:(NSString *)string;

//清理html字符串
+ (NSString *)filterHTML:(NSString *)html;

//获取规定font及width的空格字符串
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font;
+ (CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)mode;

//设置为苹方字体
+ (UIFont *)defaultTextStringFontWithSize:(CGFloat)fontSize;
+ (UIFont *)mediumTextStringFontWithSize:(CGFloat)fontSize;

// 调用电话
+ (void)callPhoneStr:(NSString*)phoneStr withVC:(UIViewController *)selfvc;

/**
 获取验证码的定时器

 @param button 倒计时的button
 */
+ (void)timeChangeWithBtn:(UIButton *)button;

/**
 在退出vc 和结束进程 倒计时结束 的时候需要还原倒计时状态
 */
+ (void)setDefaultCountDownValue;

+ (UINavigationController *)getCurrentNav;
+ (UIViewController *)getCurrentVC;

+ (NSString *)changeNull:(id)object;

+ (NSString *)getDeviceSystemName;

@end
