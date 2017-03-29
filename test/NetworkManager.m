//
//  NetworkManager.m
//  213123
//
//  Created by liman on 15-1-7.
//  Copyright (c) 2015年 liman. All rights reserved.
//

#import "NetworkManager.h"
#import "AFURLSessionManager.h"

@implementation NetworkManager

#pragma mark - public method
// GCD单例
+ (NetworkManager *)sharedInstance
{
    static NetworkManager *__singletion = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        __singletion = [[self alloc] init];
        
    });
    
    return __singletion;
}


// 请求网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数)
- (void)requestDataWithURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // 开启状态栏菊花
//    NETWORK_INDICATOR_OPEN;
    
    //----------------------------------  GET方法 ----------------------------------
    
    if ([method isEqualToString:@"GET"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
        }];
    }
    
    
    //----------------------------------  DELETE方法 ----------------------------------
    
    if ([method isEqualToString:@"DELETE"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager DELETE:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE
        }];
    }
    
    
    //----------------------------------  POST方法 ----------------------------------
    
    if ([method isEqualToString:@"POST"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE
        }];
    }
    
    
    //----------------------------------  PUT方法 ----------------------------------
    
    if ([method isEqualToString:@"PUT"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager PUT:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
        }];
    }
}



// 上传网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数)
- (void)uploadData:(NSData *)data withURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // 开启状态栏菊花
//    NETWORK_INDICATOR_OPEN;
    
    //----------------------------------  POST方法 ----------------------------------
    
    if ([method isEqualToString:@"POST"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
        //        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                                    
        
        // 6.请求
        /*
        [manager POST:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
            [self close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
            [self close];
        }];
        */
        
        // AFHTTPRequestOperation *op = 
        [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            // 处理上传的数据(非空判断, 否则crash)
            if (data && name && fileName && mimeType) {
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
            }
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
        }];
        // [op start];
    }
    
    
    //----------------------------------  PUT方法 ----------------------------------
    
    if ([method isEqualToString:@"PUT"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
        //        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager PUT:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
//            NETWORK_INDICATOR_CLOSE;
        }];
    }
}





/*
// 请求网络数据 (POST或PUT时, 需要手动拼接url?后面的参数)
- (void)requestDataWithFrontURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock
{
    // 开启状态栏菊花
    NETWORK_INDICATOR_OPEN;
    
    //---------------------------------- GET方法 ----------------------------------
    
    if ([method isEqualToString:@"GET"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager GET:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
            [self close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
            [self close];
        }];
    }
    
    
    //----------------------------------  DELETE方法 ----------------------------------
    
    if ([method isEqualToString:@"DELETE"])
    {
        // 1.初始化
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        // 2.设置请求格式 (默认二进制, 这里不用改也OK)
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //JSON请求格式
        
        
        // 3.设置超时时间
        manager.requestSerializer.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [manager.requestSerializer setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置返回格式 (默认JSON, 这里必须改为二进制)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        // 6.请求
        [manager DELETE:url parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
            [self close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
            [self close];
        }];
    }
    
    
    //----------------------------------  POST方法, PUT方法 ----------------------------------
    
    if ([method isEqualToString:@"POST"] || [method isEqualToString:@"PUT"])
    {
        // 0. 拼接完整的URL地址
        NSMutableArray *laterArr = [NSMutableArray array];
        
        for (NSString *key in [parameter allKeys]) {
            
            NSString *keyValue = [key stringByAppendingFormat:@"=%@",[parameter objectForKey:key]];
            [laterArr addObject:keyValue];
        }
        
        NSString *laterURL = [laterArr componentsJoinedByString:@"&"];
        NSString *finalURL = [url stringByAppendingFormat:@"?%@", laterURL];
        
        
        // 1.初始化
//        AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
//        NSMutableURLRequest *request = [requestSerializer requestWithMethod:method URLString:url parameters:parameter error:nil];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:finalURL]];
        
        
        // 2.设置请求类型
        request.HTTPMethod = method;
        
        
        // 3.设置超时时间
        request.timeoutInterval = timeoutInterval;
        
        
        // 4.设置消息头
        if (header) {
            
            for (NSString *key in [header allKeys]) {
                [request setValue:[header objectForKey:key] forHTTPHeaderField:key];
            }
        }
        
        
        // 5.设置消息体
        if (body) {
            
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        
        // 6.请求
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            // 成功
            successBlock(operation, responseObject);
            
            // 关闭状态栏菊花
            [self close];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            // 失败
            failureBlock(operation, error);
            
            // 关闭状态栏菊花
            [self close];
        }];
        
        [operation start];
//        [operation waitUntilFinished]; //同步
    }
}
*/



// 上传网络数据 (POST或PUT时, 不需要手动拼接url?后面的参数) || 断点续传
- (void)multipartUploadWithFilePath:(NSString *)path withURL:(NSString *)url method:(NSString *)method parameter:(NSDictionary *)parameter header:(NSDictionary *)header body:(NSString *)body name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType timeoutInterval:(NSTimeInterval)timeoutInterval result:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock progress:(void (^)(CGFloat progress))progressBlock;
{
    if ([method isEqualToString:@"POST"]) {
        
        // 1. Create `AFHTTPRequestSerializer` which will create your request.
        //    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        AFHTTPRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
        
        
        // 2. Create an `NSMutableURLRequest`.
        NSMutableURLRequest *request = [serializer multipartFormRequestWithMethod:method URLString:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            [formData appendPartWithFileURL:[NSURL URLWithString:path] name:name fileName:fileName mimeType:mimeType error:nil];
            
        } error:nil];
        
        // 3. Create and use `AFHTTPRequestOperationManager` to create an `AFHTTPRequestOperation` from the `NSMutableURLRequest` that we just created.
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *operation =
        [manager HTTPRequestOperationWithRequest:request
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             NSLog(@"Success %@", responseObject);
                                             successBlock(operation, responseObject);
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Failure %@", error.description);
                                             failureBlock(operation, error);
                                             
                                         }];
        
        // 4. Set the progress block of the operation.
        [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                            long long totalBytesWritten,
                                            long long totalBytesExpectedToWrite) {
            NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
            progressBlock(totalBytesWritten/totalBytesExpectedToWrite);
        }];
        
        // 5. Begin!
        [operation start];
    }
}

// 下载
- (void)downloadWithAddressOfHTTP:(NSString *)httpAdr success:(void (^)(NSString *filePath))successBlock failure:(void (^)(NSNumber *statusCode, NSString *message))failureBlock
{
//    // 先判断文件是否已下载
//    NSString *filePath = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:[httpAdr lastPathComponent]];
//    if ([FILE_MANAGER fileExistsAtPath:filePath]) {
//        // 文件已存在
//        successBlock(filePath);
//        return;
//    }
//    
//    
//    //----------------------------------------------------------------------------------------------
//    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:httpAdr]];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath,NSURLResponse *response) {
//        
//        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
//        
//    } completionHandler:^(NSURLResponse *response,NSURL *filePath, NSError *error) {
//        //此处已经在主线程了
//        
//        if (filePath) {
//            NSString *filePathString = [[filePath absoluteString] substringFromIndex:7];
//            successBlock(filePathString);
//        }else{
//            failureBlock([NSNumber numberWithInteger:[error code]], [error localizedDescription]);
//        }
//    }];
//    
//    [downloadTask resume];
}


@end
