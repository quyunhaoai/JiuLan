//
//  CCWarningReminderModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCWarningReminderModel : BaseModel
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) BOOL              readed;
@property (nonatomic , assign) NSInteger              days;
@property (nonatomic , assign) NSInteger              count;
@end

NS_ASSUME_NONNULL_END
/*        {
    "id": 9,
    "goods_name": "低钠食用盐",
    "image": "http://qny.chimprove.top/1592534782雪天盐主图70079.png",
    "num": 19,
    "specoption_set": [],
    "types": 0,
    "order_num": "",
    "create_time": "2020-07-03 18:04:28",
    "readed": false,
    "days": 0,
    "count": 35
}**/
