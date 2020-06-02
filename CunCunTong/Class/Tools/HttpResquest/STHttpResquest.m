//
//  STHttpResquest.m
//  StudyOC
//
//  Created by 光引科技 on 2019/9/9.
//  Copyright © 2019 光引科技. All rights reserved.
//

#import "STHttpResquest.h"
@implementation STHttpResquest

+ (instancetype)sharedManager {
    static STHttpResquest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kUrl]];
    });
    return manager;
}

+ (instancetype)sharedNetworkToolsWithoutBaseUrl
{
    static STHttpResquest *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:kUrl];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                              @"application/json",
                                                              @"text/json",
                                                              @"text/javascript",
                                                              @"text/html", nil];
    });
    return instance;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 20;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        [self.requestSerializer setValue:[self getCenterID] forHTTPHeaderField:@"CENTERID"];
        [self.requestSerializer setValue:[self getsupplierId] forHTTPHeaderField:@"MARKETID"];
        [self.requestSerializer setValue:[self getJwtoken] forHTTPHeaderField:@"JWTOKEN"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"application/json",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          @"text/json",
                                                          @"text/html", nil];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{

    [self.requestSerializer setValue:[self getCenterID] forHTTPHeaderField:@"CENTERID"];
    [self.requestSerializer setValue:[self getsupplierId] forHTTPHeaderField:@"MARKETID"];
    [self.requestSerializer setValue:[self getJwtoken] forHTTPHeaderField:@"JWTOKEN"];
    NSString *urlstr = [NSString stringWithFormat:@"%@%@",KBaseLocation,path];
    NSLog(@"url:%@\nparams:%@\nCenterID:%@\nMarketID:%@\nJWTOKEN:%@",urlstr,params,[self getCenterID],[self getsupplierId],[self getJwtoken]);
    switch (method) {
        case GET:{
            if (params.count) {
                urlstr = [CCTools urlStringWithUrl:urlstr param:params];
                urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            }
            NSLog(@"=========>%@",urlstr);
            [self GET:urlstr
           parameters:params
             progress:nil
              success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case POST:{
            [self POST:urlstr
            parameters:params
              progress:nil
               success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        case DELETE:{
            [self DELETE:urlstr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@", error);
                failure(error);
            }];
            break;
        }
        default:
            break;
    }
}
- (void)requestWithPUTMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(id)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
 {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kUrl,path]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
     if (method == POST) {
        request.HTTPMethod = @"POST";
     } else {
        request.HTTPMethod = @"PUT";
     }
    request.allHTTPHeaderFields = @{@"CENTERID":[self getCenterID],
                                    @"MARKETID":[self getsupplierId],
                                    @"JWTOKEN":[self getJwtoken],
    };
     //此处为请求头，类型为字典
    NSString *msg = [[CCTools sharedInstance] convertToJsonData:params];
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = data;
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            failure(error);
        } else {
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",dic);
            success(dic);
        }
    }] resume];
}

- (NSString *)getCenterID {
    NSString *centerID = [kUserDefaults objectForKey:@"centerID"];//centerID
    return checkNull(centerID);
}
- (NSString *)getJwtoken {
    NSString *token = [kUserDefaults objectForKey:@"token"];
    return checkNull(token);
}
- (NSString *)getsupplierId {
    NSString *supplierID = [kUserDefaults objectForKey:@"marketID"];//marketID
    return checkNull(supplierID);
}

@end
