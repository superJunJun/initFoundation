//
//  UserInfoManager.h
//  StartFoundation
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 李君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

@interface UserInfoManager : NSObject


@property (nonatomic, strong) UserInfoModel *infoModel;
@property (nonatomic, copy) NSString *sessionID;

+ (instancetype)sharedUserInfo;
- (void)setdefaultModel;

- (void)logout;
- (BOOL)isUserAccountEnable;
- (void)saveUserInfo:(NSDictionary *)dic;

@end
