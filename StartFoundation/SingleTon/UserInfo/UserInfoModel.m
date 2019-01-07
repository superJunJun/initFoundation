//
//  UserInfoModel.m
//  StartFoundation
//
//  Created by 李君 on 2019/1/4.
//  Copyright © 2019 李君. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{@"user_Id" : @"id",
             @"user_operator" : @"operator"};
}

@end
