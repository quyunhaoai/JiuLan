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

//判断是否有中文
- (NSString *)IsChinese:(NSString *)str;

+ (void)uploadTokenMultiple:(NSMutableArray *)files namespaceString:(NSString *)namespaceString percentLabel:(UILabel *)percentLabel cancleButton:(UIButton *)cancleButton finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock;
+ (void)uploadTokenMultiple:(NSMutableArray *)files namespaceString:(NSString *)namespaceString  finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock;
+ (void)upImage:(UIImage *)files name:(NSString *)name finishBlock:(void(^)(NSMutableArray *qualificationFileListArray))finishBlock;

+ (NSData *)CompressedImage:(UIImage *)sourceImage;

+ (void)srh_saveImage:(UIImage *)image completionHandle:(void (^)(NSError *, NSString *))completionHandler;
@end

NS_ASSUME_NONNULL_END
