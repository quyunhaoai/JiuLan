//
//  MallCategoryModel.h
//  XiYuanPlus
//
//  Created by xy on 2018/4/19.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SH_WithDrawalsCategoryModel : NSObject

@property (nonatomic, copy) NSString *ccid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic , copy) NSString  *image;

@end

@interface SH_MallCategoryModel : NSObject

@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * name;

@property (nonatomic , strong) NSArray <SH_WithDrawalsCategoryModel *>              * children;
@end



