//
//  NetWorkEngine.h
//  iShanggang
//
//  Created by lijun on 2017/4/11.
//  Copyright © 2017年 aishanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, ASGHTTPRequestType) {
    ISGHTTPRequest_POST,
    ISGHTTPRequest_GET,
};

typedef void(^HttpRequestCompletionBlock)(NSDictionary *result);
typedef void(^HttpRequestFailedBlock)(NSError * error);

typedef void(^ListBlock)(NSArray *listArray);
typedef void(^DictionaryBlock)(NSDictionary *result);
typedef void(^BoolBlock)(BOOL isSuccess);

@interface NetWorkEngine : NSObject

+ (AFHTTPSessionManager *)defaultNetManager;

/**
 爱上岗的 请求网络
 
 @param url URL
 @param sessionID 是否需要sessionID
 @param params 参数
 @param completionBlock 成功回调
 @param failedBlock 失败回调
 */
+ (void)postRequestWithURL:(NSString *)url
                 sessionID:(BOOL)sessionID
                    params:(NSDictionary *)params
             completeBlock:(HttpRequestCompletionBlock)completionBlock
               failedBlock:(HttpRequestFailedBlock)failedBlock;

+ (void)getRequestWithURL:(NSString *)url
                sessionID:(BOOL)sessionID
                   params:(NSDictionary *)params
            completeBlock:(HttpRequestCompletionBlock)completionBlock
              failedBlock:(HttpRequestFailedBlock)failedBlock;

/**
 图片上传（单张图片）
 
 @param url URL
 @param image 图片对象
 @param name 图片名（例如 @"img"）
 @param fileName 文件名（例如@"img.jpeg"）
 @param mimeType 图片格式（例如 @"image/jpeg"、@"image/png"）
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)requestWithURL:(NSString *)url
                 image:(UIImage *)image
                  name:(NSString *)name
              fileName:(NSString *)fileName
              mimeType:(NSString *)mimeType
               success:(HttpRequestCompletionBlock)success
                  fail:(HttpRequestFailedBlock)fail;

//支付宝 微信支付获取需要的信息
+ (void)getPaymentString:(NSString *)url
               sessionID:(BOOL)sessionID
                  params:(NSDictionary *)params
           completeBlock:(HttpRequestCompletionBlock)completionBlock
             failedBlock:(HttpRequestFailedBlock)failedBlock;

/**
 新接口参数列表
 
 @param sid sid
 @param reqData 参数字典
 @return 拼接好的参数字典
 */
+ (NSDictionary *)paraWithSid:(NSString *)sid
                  requestData:(NSDictionary *)reqData;

/**
 解析des字符串为字典
 
 @param desString DES字符串
 @return DES字符串解析后的字典
 */
+ (NSDictionary *)dictionaryWithDESString:(NSString *)desString;

/**
 检查网络是否通畅
 
 @return 网络连接YES OR NO
 */
+ (BOOL)networkConnectionIsAvailable;


@end
