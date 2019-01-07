//
//  UserInfoManager.m
//  StartFoundation
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 李君. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager

+ (void)load {
    [UserInfoManager sharedUserInfo];
}

+ (instancetype)sharedUserInfo {
    static UserInfoManager *sharedUserInfoInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUserInfoInstance = [[self alloc] init];
    });
    return sharedUserInfoInstance;
}

- (instancetype)init {
    if(self = [super init]){
        
        [self setdefaultModel];
    }
    return self;
}

- (UserInfoModel *)infoModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfoDic = [userDefaults objectForKey:@"userInfoDic"];
    
    return [UserInfoModel yy_modelWithJSON:userInfoDic];
}

- (void)setInfoModel:(UserInfoModel *)infoModel {
    //    NSDictionary *dic = [self dicWithModel:infoModel];
    NSDictionary *dic = [infoModel yy_modelToJSONObject];
    [self saveUserInfo:dic];
}

- (void)saveUserInfo:(NSDictionary *)dic {
    
    NSMutableDictionary *tempDic = @{}.mutableCopy;
    for (id key in dic.allKeys) {
        id value = dic[key];
        if ([value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        [tempDic setValue:value forKey:key];
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:tempDic forKey:@"userInfoDic"];
    [userDefaults synchronize];
}

- (void)setdefaultModel {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userInfoDic = [userDefaults objectForKey:@"userInfoDic"];
    if (!userInfoDic) {
        NSDictionary *dic = [self userAttributeSetDefaultValue];
        [self saveUserInfo:dic];
    }
    
    self.infoModel = [UserInfoModel yy_modelWithJSON:[userDefaults objectForKey:@"userInfoDic"]];
}

- (NSDictionary *)userAttributeSetDefaultValue {
    NSDictionary *dic = @{@"userId":@"0",
                          @"loginName":@"昵称",
                          @"password":@"",
                          @"name":@"",
                          @"employeeNo":@"",
                          @"levelCode":@"",
                          @"sex":@"1",
                          @"telephone":@"手机号",
                          @"email":@"",
                          @"identityCard":@"",
                          @"birthday":@"",
                          @"education":@"",
                          @"isCertification":@"",
                          @"remark":@"",
                          @"finishNum":@"",
                          @"creator":@"",
                          @"createtime":@"",
                          @"modifier":@"",
                          @"modifytime":@"",
                          @"qq":@"",
                          @"hight":@"",
                          @"weight":@"",
                          @"wechatNo":@"",
                          @"identityCardNumber":@"",
                          @"status":@"",
                          @"msg":@"",
                          @"portraitUrl":@"",
                          @"backUrl":@"",
                          @"positiveUrl":@""
                          };
    return dic;
}

- (void)logout {
    [self saveUserInfo:[self userAttributeSetDefaultValue]];
    self.sessionID = @"";
}

- (BOOL)isUserAccountEnable {
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    return sessionId.length > 0;
}

- (void)setSessionID:(NSString *)sessionID {
    [[NSUserDefaults standardUserDefaults] setObject:sessionID forKey:@"sessionId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)sessionID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
}

@end
