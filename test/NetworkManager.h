//
//  NetworkManager.h
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

typedef void(^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void(^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface NetworkManager : NSObject

// GCD单例
+ (NetworkManager *)sharedInstance;



/**
 *  @brief  请求网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数)
 */
- (void)requestDataWithURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;


/**
 *  @brief  上传网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数)
 */
// egg >>> uploadData:data name:@"" fileName:@"test.png" mimeType:@"image/jpeg"
//- (void)uploadData:(NSData *)data withURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;



/**
 *  @brief  上传网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数) || 断点续传
 */
//- (void)multipartUploadWithFilePath:(NSString *)path withURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock progress:(void (^)(CGFloat progress))progressBlock;


/**
 *  @brief  请求网络数据 (POST或PUT时, 需要手动拼接url?后面的参数)
 */
//- (void)requestDataWithFrontURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;


/**
 *  下载
 */
- (void)downloadWithAddressOfHTTP:(NSString *)httpAdr success:(void (^)(NSString *filePath))successBlock failure:(void (^)(NSNumber *statusCode, NSString *message))failureBlock;

@end
