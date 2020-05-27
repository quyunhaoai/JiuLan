//
//  CCTools.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCTools.h"

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

//    NSString *jsonString;
//
//    if (!jsonData) {
//
//    NSLog(@"%@",error);
//
//    }else{
//
//    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    }
//
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//
//    NSRange range = {0,jsonString.length};
//
//    //去掉字符串中的空格
//
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//
//    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
//
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return jsonData;

}




@end
