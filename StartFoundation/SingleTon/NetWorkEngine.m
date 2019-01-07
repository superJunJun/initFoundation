#import "NetWorkEngine.h"
#import "LoginViewController.h"
#import "BOHUDManager.h"
#import "DESUtil.h"
#import "UserInfoManager.h"
#import <CommonCrypto/CommonCrypto.h>
#import "APPURLBasicInfo.h"

#define sTestServerUrl       @"wap.baidu.com"
#define SESSIONID            [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"]

@implementation NetWorkEngine

+ (AFHTTPSessionManager *)defaultNetManager{
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]init];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/xml",@"text/plain",@"application/xml",@"text/html",nil];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //检测网络变化
        [NetWorkEngine monitorNetworkState];
    });
    return manager;
}

+ (NSString *)mergedRequestUrl:(NSString *)url {
    if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
        return url;
    }
    NSString *isgPrefix = [APPURLBasicInfo sharedInstance].isgBasicUrl;
    NSString *chimaPrefix = [APPURLBasicInfo sharedInstance].chimaBasicUrl;
    if ([url hasPrefix:isgPrefix] || [url hasPrefix:chimaPrefix]) {
        return url;
    }
    
    NSString *mergeUrl = [isgPrefix stringByAppendingString:url];
    return mergeUrl;
}

+ (void)postRequestWithURL:(NSString *)url
                 sessionID:(BOOL)sessionID
                    params:(NSDictionary *)params
             completeBlock:(HttpRequestCompletionBlock)completionBlock
               failedBlock:(HttpRequestFailedBlock)failedBlock {
    [self requestWithURLStr:url HTTPType:ISGHTTPRequest_POST hasSessionId:sessionID params:params completeBlock:completionBlock failedBlock:failedBlock];
}

+ (void)getRequestWithURL:(NSString *)url
                sessionID:(BOOL)sessionID
                   params:(NSDictionary *)params
            completeBlock:(HttpRequestCompletionBlock)completionBlock
              failedBlock:(HttpRequestFailedBlock)failedBlock {
    [self requestWithURLStr:url HTTPType:ISGHTTPRequest_GET hasSessionId:sessionID params:params completeBlock:completionBlock failedBlock:failedBlock];
}

+ (void)requestWithURLStr:(NSString *)URLStr
                 HTTPType:(ASGHTTPRequestType)type
             hasSessionId:(BOOL)hasSessionId
                   params:(NSDictionary *)params
            completeBlock:(HttpRequestCompletionBlock)completionBlock
              failedBlock:(HttpRequestFailedBlock)failedBlock {
    
    AFHTTPSessionManager *manager = [NetWorkEngine defaultNetManager];
    if(![self networkConnectionIsAvailable]) {
        [BOHUDManager showErrorNet];
//        [[BOHUDManager defaultManager] progressHUDShowWithCompleteText:@"请检查网络" isSucceed:NO];
        failedBlock(nil);
        return;
    }
    NSString *wholeURL = [[APPURLBasicInfo sharedInstance].isgBasicUrl stringByAppendingString:URLStr];
    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"ice-client-type"];
    if (hasSessionId) {
        //        NSString *session = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBUFAiLCJ1c2VyX2lkIjoiMSIsImlzcyI6IlNlcnZpY2UiLCJleHAiOjE1NzYyMzY2MTQsImlhdCI6MTU0NDcwMDYxNH0.iyrh7GvnJIUskqfk3H4TXFs7R9RXJTE5vxgf7BWDSF8";
        //        [manager.requestSerializer setValue:session forHTTPHeaderField:@"ice-user-token"];
        [manager.requestSerializer setValue:SESSIONID forHTTPHeaderField:@"ice-user-token"];
    }
    if (type == ISGHTTPRequest_GET) {
        
        [manager GET:wholeURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successWithUrlStr:wholeURL params:params responseObject:responseObject completionBlock:completionBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"******************************************错误信息:%@*************************************对应的URL为：%@*************************************", error, wholeURL);
            failedBlock(error);
        }];
    }
    
    if (type == ISGHTTPRequest_POST) {
        
        [manager POST:wholeURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self successWithUrlStr:wholeURL params:params responseObject:responseObject completionBlock:completionBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"******************************************错误信息:%@*************************************对应的URL为：%@*************************************", error, wholeURL);
            failedBlock(error);
        }];
    }
}

// 图片上传（单张图片）
+ (void)requestWithURL:(NSString *)url
                 image:(UIImage *)image
                  name:(NSString *)name
              fileName:(NSString *)fileName
              mimeType:(NSString *)mimeType
               success:(HttpRequestCompletionBlock)success
                  fail:(HttpRequestFailedBlock)fail
{
    AFHTTPSessionManager *manager = [NetWorkEngine defaultNetManager];
    if(![self networkConnectionIsAvailable]) {
        [BOHUDManager showErrorNet];
        //        [[BOHUDManager defaultManager] progressHUDShowWithCompleteText:@"请检查网络" isSucceed:NO];
        fail(nil);
        return;
    }
    
    NSString *wholeURL = [[APPURLBasicInfo sharedInstance].isgBasicUrl stringByAppendingString:url];
    [manager.requestSerializer setValue:SESSIONID forHTTPHeaderField:@"ice-user-token"];
    [manager.requestSerializer setValue:@"app" forHTTPHeaderField:@"ice-client-type"];
    [manager POST:wholeURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *picData = UIImageJPEGRepresentation(image, 0.5);
        [formData appendPartWithFileData:picData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self successWithUrlStr:wholeURL params:nil responseObject:responseObject completionBlock:success];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"******************************************错误信息:%@*************************************对应的URL为：%@*************************************", error, wholeURL);
        fail(error);
    }];
}

////支付宝 微信支付获取需要的信息
//+ (void)getPaymentString:(NSString *)url
//               sessionID:(BOOL)sessionID
//                  params:(NSDictionary *)params
//           completeBlock:(HttpRequestCompletionBlock)completionBlock
//             failedBlock:(HttpRequestFailedBlock)failedBlock {
//
//    AFHTTPSessionManager *manager = [NetWorkEngine defaultNetManager];
//    if(![self networkConnectionIsAvailable])
//    {
//        [[BOHUDManager defaultManager] progressHUDShowWithCompleteText:@"请检查网络" isSucceed:NO];
//        failedBlock(nil);
//        return;
//    }
//
//    NSString *wholeURL = [self mergedRequestUrl:url];
//    if (sessionID) {
//        [manager.requestSerializer setValue:SESSIONID forHTTPHeaderField:@"sessionId"];
//    }
//    [manager GET:wholeURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        id data = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                  options:NSJSONReadingMutableContainers
//                                                    error:nil];
//        NSLog(@"***************************************请求URL为: %@****************************************请求参数:%@***********************************返回结果：%@*************************************",wholeURL, params, data);
//        if (data) {
//            if ([data objectForKey:@"retCode"]) {
//                // !!!这里没做session过期处理，直接返回了。
//                completionBlock(data);
//            } else if ([data objectForKey:@"status"]){
//                if ([[data objectForKey:@"status"] integerValue] == 200) {
//                    [[BOHUDManager defaultManager] progressHUDHideImmediately];
//                    [[BONoticeBar defaultBar] setNoticeText:@"登录过期，请重新登录"];
//                    [[ISGUserInfo sharedUserInfo] logout];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:ForceLoginNoti object:nil];
//
//                    LoginViewController *loginVC = [LoginViewController new];
//                    UINavigationController *nav = [BOAssistor getCurrentNav];
//                    [nav pushViewController:loginVC animated:YES];
//                } else {
//                    completionBlock(data);
//                }
//            } else {
//                completionBlock(data);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"******************************************错误信息:%@*************************************对应的URL为：%@*************************************", error, wholeURL);
//        failedBlock(error);
//    }];
//}

+ (void)successWithUrlStr:(NSString *)urlStr params:(NSDictionary *)params responseObject:(id)responseObject completionBlock:(HttpRequestCompletionBlock)completionBlock {
    id data = [NSJSONSerialization JSONObjectWithData:responseObject
                                              options:NSJSONReadingMutableContainers
                                                error:nil];
    NSLog(@"***************************************请求URL为: %@****************************************请求参数:%@***********************************返回结果：%@*************************************",urlStr, params, data);
    if (data) {
        if ([data objectForKey:@"retCode"]) {
            // !!!这里没做session过期处理，直接返回了。
            completionBlock(data);
        } else if ([data objectForKey:@"status"]) {
            if ([[data objectForKey:@"status"] integerValue] == 200 || [[data objectForKey:@"status"] integerValue] == -99 ) {
                [BOHUDManager showBriefAlert:@"登录过期，请重新登录"];
                
                [[UserInfoManager sharedUserInfo] logout];
            } else {
                completionBlock(data);
            }
        } else {
            completionBlock(data);
        }
    }
}

#pragma mark - new para 新参数列表
+ (NSDictionary *)paraWithSid:(NSString *)sid
                  requestData:(NSDictionary *)reqData {
    
    NSData *reqJsonData = [NSJSONSerialization dataWithJSONObject:reqData options:NSJSONWritingPrettyPrinted error:nil];
    NSString *reqJsonString = [[NSString alloc]initWithData:reqJsonData encoding:NSUTF8StringEncoding];
    reqJsonString = [reqJsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    reqJsonString = [reqJsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *reqDesStr = [DESUtil encryptWithText:reqJsonString];
    NSString *merchantId = @"asgApi";
    NSString *version = @"1.0.1";
    NSString *signStr = [NSString stringWithFormat:@"merchantId=%@&reqData=%@&sid=%@&version=%@",merchantId,reqDesStr,sid,version];
    NSString *MD5signStr = [self md5:signStr];
    
    NSDictionary *pramas = @{
                             @"version":version,
                             @"sid":sid,
                             @"merchantId":merchantId,
                             @"reqData":reqDesStr,
                             @"sign":MD5signStr,
                             };
    return pramas;
}

+ (NSDictionary *)dictionaryWithDESString:(NSString *)desString {
    NSString *retStr = [DESUtil decryptWithText:desString];
    NSData *jsonData = [retStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return jsonDic;
}

#pragma mark - other
+ (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

+ (BOOL)networkConnectionIsAvailable
{
    SCNetworkReachabilityFlags flags;
    // Recover reachability flags
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(CFAllocatorGetDefault(), [sTestServerUrl UTF8String]);
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
    CFRelease(reachability);
    //如果不能获取连接标志，则不能连接网络，直接返回
    if(!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark - 监测网络状态
+ (void)monitorNetworkState{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:sNetworkState object:nil userInfo:@{@"netType":@"NotReachable"}]];
                break;
            case AFNetworkReachabilityStatusUnknown:
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:sNetworkState object:nil userInfo:@{@"netType":@"Unknown"}]];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:sNetworkState object:nil userInfo:@{@"netType":@"Unknown"}]];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:sNetworkState object:nil userInfo:@{@"netType":@"WWAN"}]];
                break;
            default:
                break;
        }
    }];
}

@end
