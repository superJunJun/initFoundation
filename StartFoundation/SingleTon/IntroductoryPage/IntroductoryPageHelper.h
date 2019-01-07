//
//  IntroductoryPageHelper.h
//  iShanggang
//
//  Created by  bxf on 2018/1/10.
//  Copyright © 2018年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntroductoryPageHelper : NSObject

+ (instancetype)shareInstance;

+ (void)showIntroductoryPageView:(NSArray *)imageArray;

@end
