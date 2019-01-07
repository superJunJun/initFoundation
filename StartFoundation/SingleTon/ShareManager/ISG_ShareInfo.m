//
//  ISG_ShareInfo.m
//  iShanggang
//
//  Created by lijun on 2017/8/22.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import "ISG_ShareInfo.h"

@implementation ISG_ShareInfo

- (id)initWithDictionary:(NSDictionary *)dictionary{
    self=[super init];
    if (self)
    {
        self.title = [dictionary objectForKey:@"title"];
        self.shareUrl = [dictionary objectForKey:@"url"];
        self.content = [dictionary objectForKey:@"content"];
        self.shareIcon = [dictionary objectForKey:@"shareIcon"];
    }
    return self;
}

+ (instancetype )shareInfoWithDictionary:(NSDictionary *)dictionary{
    return [[self alloc] initWithDictionary:dictionary];
}

@end
