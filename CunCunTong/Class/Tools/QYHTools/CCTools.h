//
//  CCTools.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCTools : NSObject

/**单例方法*/
+ (id)sharedInstance;

-(void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor;

- (void)addTowColorToView:(UIView *)view StartColor:(UIColor *)color1 endColor:(UIColor *)color2;

- (void)addborderToView:(UIView *)view width:(CGFloat )width color:(UIColor *)color;

+ (NSString *)urlStringWithUrl:(NSString *)url param:(NSDictionary *)param;

//字典转json
-(NSString *)convertToJsonData:(NSDictionary *)dict;

-(NSData *)dictToJsonData:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
