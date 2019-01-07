//
//  ISG_ShareInfo.h
//  iShanggang
//
//  Created by lijun on 2017/8/22.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISG_ShareInfo : NSObject

@property (nonatomic, copy) NSString *title;          //招聘名称
@property (nonatomic, copy) NSString *shareUrl;   //分享url
@property (nonatomic, copy) NSString *content;      //招聘内容
@property (nonatomic, copy) NSString *shareIcon;

+ (instancetype )shareInfoWithDictionary:(NSDictionary *)dictionary;

@end
