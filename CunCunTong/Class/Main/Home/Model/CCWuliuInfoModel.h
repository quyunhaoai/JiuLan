//
//  CCWuliuInfoModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface From :NSObject
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) CGFloat              lat;
@property (nonatomic , assign) CGFloat              lng;

@end


@interface To :NSObject
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , assign) CGFloat              lat;
@property (nonatomic , assign) CGFloat              lng;

@end


@interface CrossItem :NSObject
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * info;
@property (nonatomic , assign) CGFloat              lat;
@property (nonatomic , assign) CGFloat              lng;

@end
@interface CCWuliuInfoModel : BaseModel
@property (nonatomic , strong) From              * from;
@property (nonatomic , strong) To              * to;
@property (nonatomic , strong) NSArray <CrossItem *>              * cross;
@end

NS_ASSUME_NONNULL_END
