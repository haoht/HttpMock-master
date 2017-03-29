LMHttpMock
================

iOS App开发过程中，前台开发过程通常都是并行进行的，因此难免会出现一些客户端需要等待后台开发联调的情景，等待的过程往往痛若而无奈（后台被催得痛苦，前端无奈等待）。

LMHttpMock 是开源的 iOS 请求模拟工具，用于iOS App网络层开发，可以模拟指定的 HTTP request，并完全替换真实的网络返回数据。实际开发过程中, server端开发者只需要给iOS开发者一份API接口文档即可, 十分节约开发时间。


#### 1.启动http模拟服务 (具体请查看demo)

    MockRequest *request1 = [[MockRequest alloc] initWithMethod:@"GET" path:@"/111" parameter:@{@"para1":@"para1"} header:@{@"header1":@"header1"} delay:0.5 responseJson:@{@"result1":@"result1"}];

    MockRequest *request2 = [[MockRequest alloc] initWithMethod:@"GET" path:@"/222" parameter:@{@"para2":@"para2"} header:@{@"header2":@"header2"} delay:0.5 responseJsonFile:@"test_get.json" jsonFileLocation:JsonFileLocation_Bundle];

    MockRequest *request3 = [[MockRequest alloc] initWithMethod:@"POST" path:@"/333" parameter:@{@"para3":@"para3"} header:@{@"header3":@"header3"} delay:0.5 responseJson:@{@"result3":@"result3"}];

    MockRequest *request4 = [[MockRequest alloc] initWithMethod:@"POST" path:@"/444" parameter:@{@"para4":@"para4"} header:@{@"header4":@"header4"} delay:0.5 responseJsonFile:[self saveBundleToSandbox:@"test_post.json"] jsonFileLocation:JsonFileLocation_Sandbox];
    
    
    [LMHttpMock start:@[request1, request2, request3, request4] port:8888 result:^(NSURL *serverURL) {
        
        NSLog(@"_______________%@", serverURL);
    }];

#### 2.验证http模拟服务 (具体请查看demo)

	[[NetworkManager sharedInstance] requestDataWithURL:@"http://localhost:8888/111" method:@"GET" parameter:@{@"para1":@"para1"} header:@{@"header1":@"header1"} body:nil timeoutInterval:MAXFLOAT result:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *jsonDict = [[JSONManager alloc] transformDatatodic:responseObject];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET success:\n %@", jsonDict]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET fail:\n %@", error.userInfo[@"NSLocalizedDescription"]]];
    }];
