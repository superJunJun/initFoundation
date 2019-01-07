//
//  BeeCloudPayManager.h
//  iShanggang
//
//  Created by  bxf on 2017/6/29.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeeCloud.h"

typedef void(^PayResultBlock)(NSDictionary *result);

@interface BeeCloudPayManager : NSObject

@property (nonatomic, copy) PayResultBlock resultBlock;
//- (void)doPay:(PayChannel)channel;
+ (instancetype )payManager;
- (void)doPay:(PayChannel)channel
         info:(NSDictionary *)billInfo;

- (void)initializeBeeCloudIDWithSource:(NSString *)source;

@end
