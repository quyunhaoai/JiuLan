//
//  BaseModel.m
//  lianxi_3
//
//  Created by lanou3g on 16/4/18.
//  Copyright © 2016年 张静. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
//+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary {
//    NSArray *imageArray = dictionary[@"imageurls"];
//    switch (imageArray.count) {
//        case 0:
//        {
//            TextModel *textModel = [TextModel new];
//            [textModel setValuesForKeysWithDictionary:dictionary];
//            return textModel;
//        }
//            break;
//            case 1:
//        {
//            ImageModel *imageModel = [ImageModel new];
//            [imageModel setValuesForKeysWithDictionary:dictionary];
//            return imageModel;
//        }
//            break;
//            case 3:
//        {
//            MulImageModel *mImgModel = [MulImageModel new];
//            [mImgModel setValuesForKeysWithDictionary:dictionary];
//            return mImgModel;
//        }
//            break;
//            
//        default:
//            break;
//    }
//    return nil;
//}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
+(CGFloat)height {
    return 0.f;
}
@end
