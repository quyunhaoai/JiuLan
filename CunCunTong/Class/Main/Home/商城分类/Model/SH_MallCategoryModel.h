//
//  MallCategoryModel.h
//  XiYuanPlus
//
//  Created by xy on 2018/4/19.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SH_MallCategoryModel : NSObject

@property (nonatomic, copy) NSString *key;  //
@property (nonatomic, copy) NSString *categoryImgURL;  //
@property (nonatomic, copy) NSString *categoryID;  //
@property (nonatomic, copy) NSString *categoryName;  //
@property (nonatomic, strong) NSMutableArray *child;  //

@end


@interface SH_WithDrawalsCategoryModel : NSObject

@property (nonatomic, copy) NSString *dramaID;  //
@property (nonatomic, copy) NSString *dramaName;  //

@end
