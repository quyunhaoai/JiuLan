//
//  CCPersonCenterModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Order_count :NSObject
@property (nonatomic , assign) NSInteger              count0;
@property (nonatomic , assign) NSInteger              count1;
@property (nonatomic , assign) NSInteger              count2;

@end
@interface CCPersonCenterModel : BaseModel
@property (nonatomic , copy) NSString              * head_photo;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , assign) NSInteger              balance;
@property (nonatomic , strong) Order_count              * order_count;
@property (nonatomic , assign) NSInteger              message_count;
@property (nonatomic , assign) NSInteger              warn_count;
@end

NS_ASSUME_NONNULL_END
/*{
    "head_photo": "http://qny.chimprove.top/1593251315378imageCCC",
    "mobile": "12345677711",
    "balance": 9913480.0,
    "order_count": {
        "count0": 6,
        "count1": 2,
        "count2": 3
    },
    "message_count": 1,
    "warn_count": 1
}**/
