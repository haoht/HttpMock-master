//
//  ViewController.m
//  test
//
//  Created by liman on 6/14/16.
//  Copyright © 2016 liman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - tool
// fileName参数: test_post.json
- (NSString *)saveBundleToSandbox:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForAuxiliaryExecutable:fileName];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:[jsonDict copy]
                                                   options:0
                                                     error:nil];
    
    

    //沙盒路径
    NSString *path = [SANDBOX_DOCUMENT_PATH stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return fileName;
    }
    
    if ([data writeToFile:path atomically:YES]) {
        return fileName;
    }
    
    return nil;
}

#pragma mark - init
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"test";
    
    [self initButtons];
    
    // 配置HttpMock
    [self setupHttpMock];
}

#pragma mark - private
- (void)initButtons
{
    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(0, 64, SCREEN_WIDTH, 80);
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"test GET request" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testGET) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:0];
    btn2.frame = CGRectMake(0, 164, SCREEN_WIDTH, 80);
    btn2.backgroundColor = [UIColor lightGrayColor];
    [btn2 setTitle:@"test GET request (json file)" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(testGET_jsonFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:0];
    btn3.frame = CGRectMake(0, 264, SCREEN_WIDTH, 80);
    btn3.backgroundColor = [UIColor lightGrayColor];
    [btn3 setTitle:@"test POST request" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(testPOST) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:0];
    btn4.frame = CGRectMake(0, 364, SCREEN_WIDTH, 80);
    btn4.backgroundColor = [UIColor lightGrayColor];
    [btn4 setTitle:@"test POST request (json file)" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(testPOST_jsonFile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
}

// 配置HttpMock
- (void)setupHttpMock
{
    MockRequest *request1 = [[MockRequest alloc] initWithMethod:@"GET" path:@"/111" parameter:@{@"para1":@"para1"} header:@{@"header1":@"header1"} delay:0.5 responseJson:@{@"result1":@"result1"}];
    
    MockRequest *request2 = [[MockRequest alloc] initWithMethod:@"GET" path:@"/222" parameter:@{@"para2":@"para2"} header:@{@"header2":@"header2"} delay:0.5 responseJsonFile:@"test_get.json" jsonFileLocation:JsonFileLocation_Bundle];
    
    MockRequest *request3 = [[MockRequest alloc] initWithMethod:@"POST" path:@"/333" parameter:@{@"para3":@"para3"} header:@{@"header3":@"header3"} delay:0.5 responseJson:@{@"result3":@"result3"}];
    
    MockRequest *request4 = [[MockRequest alloc] initWithMethod:@"POST" path:@"/444" parameter:@{@"para4":@"para4"} header:@{@"header4":@"header4"} delay:0.5 responseJsonFile:[self saveBundleToSandbox:@"test_post.json"] jsonFileLocation:JsonFileLocation_Sandbox];
    
    
    
    // 启动http模拟服务
    [LMHttpMock start:@[request1, request2, request3, request4] port:8888 result:^(NSURL *serverURL) {
        
        NSLog(@"_______________%@", serverURL);
    }];
}


#pragma mark - target action
- (void)testGET
{
    [[HUDHelper sharedInstance] loading];
    
    [[NetworkManager sharedInstance] requestDataWithURL:@"http://localhost:8888/111" method:@"GET" parameter:@{@"para1":@"para1"} header:@{@"header1":@"header1"} body:nil timeoutInterval:MAXFLOAT result:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[HUDHelper sharedInstance] stopLoading];
        NSDictionary *jsonDict = [[JSONManager alloc] transformDatatodic:responseObject];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET success:\n %@", jsonDict]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[HUDHelper sharedInstance] stopLoading];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET fail:\n %@", error.userInfo[@"NSLocalizedDescription"]]];
    }];
}

- (void)testGET_jsonFile
{
    [[HUDHelper sharedInstance] loading];
    
    [[NetworkManager sharedInstance] requestDataWithURL:@"http://localhost:8888/222" method:@"GET" parameter:@{@"para2":@"para2"} header:@{@"header2":@"header2"} body:nil timeoutInterval:MAXFLOAT result:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[HUDHelper sharedInstance] stopLoading];
        NSDictionary *jsonDict = [[JSONManager alloc] transformDatatodic:responseObject];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET success:\n %@", jsonDict]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[HUDHelper sharedInstance] stopLoading];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"GET fail:\n %@", error.userInfo[@"NSLocalizedDescription"]]];
    }];
}

- (void)testPOST
{
    [[HUDHelper sharedInstance] loading];
    
    [[NetworkManager sharedInstance] requestDataWithURL:@"http://localhost:8888/333" method:@"POST" parameter:@{@"para3":@"para3"} header:@{@"header3":@"header3"} body:nil timeoutInterval:MAXFLOAT result:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[HUDHelper sharedInstance] stopLoading];
        NSDictionary *jsonDict = [[JSONManager alloc] transformDatatodic:responseObject];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"POST success:\n %@", jsonDict]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[HUDHelper sharedInstance] stopLoading];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"POST fail:\n %@", error.userInfo[@"NSLocalizedDescription"]]];
    }];
}

- (void)testPOST_jsonFile
{
    [[HUDHelper sharedInstance] loading];
    
    [[NetworkManager sharedInstance] requestDataWithURL:@"http://localhost:8888/444" method:@"POST" parameter:@{@"para4":@"para4"} header:@{@"header4":@"header4"} body:nil timeoutInterval:MAXFLOAT result:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[HUDHelper sharedInstance] stopLoading];
        NSDictionary *jsonDict = [[JSONManager alloc] transformDatatodic:responseObject];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"POST success:\n %@", jsonDict]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[HUDHelper sharedInstance] stopLoading];
        [UIAlertView showWithMessage:[NSString stringWithFormat:@"POST fail:\n %@", error.userInfo[@"NSLocalizedDescription"]]];
    }];
}

@end
