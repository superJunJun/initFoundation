//
//  DESUtil.h
//

#import <Foundation/Foundation.h>

@interface DESUtil : NSObject

+ (NSString *)encryptWithText:(NSString *)sText;
+ (NSString *)decryptWithText:(NSString *)sText;

@end
