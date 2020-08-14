//
//  CCTools.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTools.h"
#import <Qiniu/QiniuSDK.h>
#import <Photos/Photos.h>
@implementation CCTools

/**单例方法*/
+ (id)sharedInstance
{
    static id _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}
+ (NSString *)urlStringWithUrl:(NSString *)url param:(NSDictionary *)param{
    if (!param.count) {
        return url;
    }
    NSMutableArray *parts = [NSMutableArray array];
    [param enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",key,value
//                          [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
//                          [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    NSString *paramString = [parts componentsJoinedByString:@"&"];
    if(!paramString.length){
        return url;
    }

    if(!url.length){
        url = @"";
    }
    if ([url containsString:@"?"]) {
          return [NSString stringWithFormat:@"%@&%@",url,paramString];
    }
    return [NSString stringWithFormat:@"%@?%@",url,paramString];
}



/// 添加四边阴影效果
-(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = 5;
    
    theView.layer.masksToBounds = NO;
}
- (void)addTowColorToView:(UIView *)view StartColor:(UIColor *)color1 endColor:(UIColor *)color2 {
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1.0, 0);
    _gradientLayer.frame = view.bounds;
    [view.layer addSublayer:_gradientLayer];
}

- (void)addborderToView:(UIView *)view width:(CGFloat)width color:(UIColor *)color {
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
}

-(NSString *)convertToJsonData:(NSDictionary *)dict

{

    NSError *error;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString;

    if (!jsonData) {

    NSLog(@"%@",error);

    }else{

    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    }

    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];

    NSRange range = {0,jsonString.length};

    //去掉字符串中的空格

    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];

    NSRange range2 = {0,mutStr.length};

    //去掉字符串中的换行符

    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;

}

-(NSData *)dictToJsonData:(NSDictionary *)dict
{
     NSError *error;
     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
     return jsonData;
}


//判断是否有中文
- (NSString *)IsChinese:(NSString *)str {
    NSString *newString = str;
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            NSString *oldString = [str substringWithRange:NSMakeRange(i, 1)];
            NSString *string = [oldString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            newString = [newString stringByReplacingOccurrencesOfString:oldString withString:string];
        } else{
            
        }
    }
    return newString;
}

/**
 上传七牛 多图片文件
 
 @param files files 文件数组
 @param namespaceString 命名空间
 @param percentLabel 上传进度label
 @param cancleButton 取消上传button
 @param finishBlock 请求体 数组
 */
+ (void)upImage:(UIImage *)files name:(NSString *)name finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock {
    XYWeakSelf;
    
        NSDictionary *parameter = @{@"name":name};
        [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/app/qiniutoken/" WithParams:parameter WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
            NSInteger status = [[dic objectForKey:@"errno"] integerValue];
            NSString *msg = [[dic objectForKey:@"errmsg"] description];
            if(status == 0){
    //        //  修改图片的请求体
            NSMutableArray *qualificationFileListArray = [NSMutableArray array];
//            @autoreleasepool {
//                for (int i = 0; i < files.count; i ++) {
//                    [qualificationFileListArray addObject:@(i)];
//                }
//            }
            NSDictionary *dict = dic[@"data"];
            NSString *token = dict[@"token"];
            NSString *key = dict[@"name"];
            NSString *url = dict[@"url"];
            QNUploadManager *QNManager = [[QNUploadManager alloc] init];
            QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:key progressHandler:^(NSString *key, float percent){
            }
            
            params:@{ @"x:foo":@"fooval"}
            checkCrc:YES
            cancellationSignal:^BOOL(){
                   /******该控制器销毁的时候，取消上传*******/
                return NO;
            }];
            NSData *headerData = [weakSelf CompressedImage:files];//[weakSelf CompressedImage:[files objectAtIndex:i]];
            [QNManager putData:headerData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            /******上传成功七牛的返回体*******/
                
                    if(info.ok)
                    {
                        NSLog(@"请求成功");
                    }
                    else{
                        NSLog(@"失败");
                                //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                    }
                    NSLog(@"info ===== %@", info);
                    NSLog(@"resp ===== %@", resp);
                    if (resp) {
                        [qualificationFileListArray addObject:[NSString stringWithFormat:@"%@/%@",url,resp[@"key"]]];
//                        [qualificationFileListArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@/%@",url,resp[@"key"]]];
                        finishBlock(qualificationFileListArray);
                    } else {

                        [MBManager hideAlert];
                        [MBManager showBriefAlert:@"上传失败"];
                        return ;
                    }
            
        } option:opt];
    }else {
        if (msg.length>0) {
            [MBManager showBriefAlert:msg];
        }
    }
} WithFailurBlock:^(NSError * _Nonnull error) {
            
}];
}
/******判断图片大小，是否进行压缩处理*******/
+ (NSData *)CompressedImage:(UIImage *)sourceImage {
    NSData *targetData = UIImagePNGRepresentation(sourceImage);
    if (targetData.length >= 307200) {
        targetData=UIImageJPEGRepresentation(sourceImage, 0.7);
    }
    return targetData;
}
+ (void)uploadTokenMultiple:(NSMutableArray *)files namespaceString:(NSString *)namespaceString percentLabel:(UILabel *)percentLabel cancleButton:(UIButton *)cancleButton finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock {
    
  //七牛云上传
    if (files.count == 0) {
        return;
    }
    //        //  修改图片的请求体
    NSMutableArray *qualificationFileListArray = [NSMutableArray array];
    @autoreleasepool {
        for (int i = 0; i < files.count; i ++) {
            [qualificationFileListArray addObject:@(i)];
        }
    }
    __block NSInteger x = 0; // 验证次数。当x == i 时 可提交
    
    for(int i = 0; i < files.count;i++){
    XYWeakSelf;
    NSDictionary *parameter = @{@"name":[NSString stringWithFormat:@"%@%ld",namespaceString,(long)i]};
    [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/app/qiniutoken/" WithParams:parameter WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            NSDictionary *dict = dic[@"data"];
            NSString *token = dict[@"token"];
            NSString *key = dict[@"name"];
            NSString *url = dict[@"url"];
            QNUploadManager *QNManager = [[QNUploadManager alloc] init];
            QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:key progressHandler:^(NSString *key, float percent){
            }
            //@{ @"x:index":index }
            params:@{ @"x:foo":@"fooval"}
            checkCrc:YES
            cancellationSignal:^BOOL(){
               /******该控制器销毁的时候，取消上传*******/
               return NO;
            }];
            NSData *headerData = [weakSelf CompressedImage:[files firstObject]];//[weakSelf CompressedImage:[files objectAtIndex:i]];
            [QNManager putData:headerData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                /******上传成功七牛的返回体*******/
                if(info.ok)
                {
                    NSLog(@"请求成功");
                }
                else{
                    NSLog(@"失败");
                    //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                }
                NSLog(@"info ===== %@", info);
                NSLog(@"resp ===== %@", resp);
                if (resp) {
                    [qualificationFileListArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@/%@",url,resp[@"key"]]];
                    x ++;
                    if (x == files.count) {
                        finishBlock(qualificationFileListArray);
                    }
                } else {
                    x = 0;
                    [MBManager hideAlert];
                    [MBManager showBriefAlert:@"上传失败"];
                    return ;
                }
            } option:opt];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
    }
}

+ (void)uploadTokenMultiple:(NSMutableArray *)files namespaceString:(NSString *)namespaceString  finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock {
    
  //七牛云上传
    if (files.count == 0) {
        return;
    }
    XYWeakSelf;
    NSDictionary *parameter = @{@"name":namespaceString};
    [[STHttpResquest sharedManager] requestWithMethod:POST WithPath:@"/app/qiniutoken/" WithParams:parameter WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
//        //  修改图片的请求体
        NSMutableArray *qualificationFileListArray = [NSMutableArray array];
        @autoreleasepool {
            for (int i = 0; i < files.count; i ++) {
                [qualificationFileListArray addObject:@(i)];
            }
        }
        __block NSInteger x = 0; // 验证次数。当x == i 时 可提交
        for(int i = 0; i < files.count;i++){
            NSDictionary *dict = dic[@"data"];
            NSString *token = dict[@"token"];
            NSString *key = dict[@"name"];
            NSString *url = dict[@"url"];
            QNUploadManager *QNManager = [[QNUploadManager alloc] init];
            QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:key progressHandler:^(NSString *key, float percent){
            }
                                                                params:@{ @"x:foo":@"fooval" }
                                                              checkCrc:YES
                                                    cancellationSignal:^BOOL(){
                                                        /******该控制器销毁的时候，取消上传*******/
                                                            return NO;
                                                    }];
            NSData *headerData = [weakSelf CompressedImage:[files objectAtIndex:i]];
            [QNManager putData:headerData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                /******上传成功七牛的返回体*******/
                if(info.ok)
                {
                    NSLog(@"请求成功");
                }
                else{
                    NSLog(@"失败");
                    //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                }
                NSLog(@"info ===== %@", info);
                NSLog(@"resp ===== %@", resp);
                if (resp) {
                   
                    [qualificationFileListArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@/%@",url,resp[@"key"]]];
                    x ++;
                    if (x == files.count) {
                        finishBlock(qualificationFileListArray);
                    }
                } else {
                    x = 0;
                    [MBManager hideAlert];
                    [MBManager showBriefAlert:@"上传失败"];
                    return ;
                }
            } option:opt];
        }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        
    }];
}
+ (void)srh_saveImage:(UIImage *)image completionHandle:(void (^)(NSError *, NSString *))completionHandler {
    // 1. 获取照片库对象
       PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
       
       // 假如外面需要这个 localIdentifier ，可以通过block传出去
       __block NSString *localIdentifier = @"sss";
       
       // 2. 调用changeblock
       [library performChanges:^{
           
           // 2.1 创建一个相册变动请求
           PHAssetCollectionChangeRequest *collectionRequest = [self getCurrentPhotoCollectionWithAlbumName:@"photo"];
           
           // 2.2 根据传入的照片，创建照片变动请求
           PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
           
           // 2.3 创建一个占位对象
           PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
           localIdentifier = placeholder.localIdentifier;
           
           // 2.4 将占位对象添加到相册请求中
           [collectionRequest addAssets:@[placeholder]];
           
       } completionHandler:^(BOOL success, NSError * _Nullable error) {
           
           if (error) {
//               [iConsole log:@"保存照片出错>>>%@", [error description]];
               completionHandler(error, nil);
           } else {
               completionHandler(nil, localIdentifier);
           }
       }];
}
+ (PHAssetCollectionChangeRequest *)getCurrentPhotoCollectionWithAlbumName:(NSString *)albumName {
    // 1. 创建搜索集合
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 2. 遍历搜索集合并取出对应的相册，返回当前的相册changeRequest
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle containsString:albumName]) {
            PHAssetCollectionChangeRequest *collectionRuquest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            return collectionRuquest;
        }
    }
    
    // 3. 如果不存在，创建一个名字为albumName的相册changeRequest
    PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
    return collectionRequest;
}
@end
