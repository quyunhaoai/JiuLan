//
//  CCReternGoodsDetailMdoel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/6/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"
#import "CCBackOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN



@interface Driver_info :NSObject
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * mobile;

@end
@interface CCReternGoodsDetailMdoel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * play_unit;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray <Batch_setItem *>              * batch_set;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * check_time;
@property (nonatomic , copy) NSString              * finish_time;
@property (nonatomic , copy) NSString              * pay_time;
@property (nonatomic , copy) NSString              * recive_time;
@property (nonatomic , copy) NSString              * refuse_reason;
@property (nonatomic , copy) NSString              * remark;
@property (nonatomic , copy) NSString              * update_time;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * back_reason;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic , assign) CGFloat              total_play_price;
@property (nonatomic , assign) CGFloat              play_price;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , strong) Driver_info              * driver_info;
@property (strong, nonatomic) NSArray *specoption_set;
@property (strong, nonatomic) NSArray *order_photo_set;



@property (nonatomic , copy) NSString              * product_date;

@property (nonatomic , assign) NSInteger              audit_level;
@property (nonatomic , assign) NSInteger              types;

@property (nonatomic , assign) NSInteger              count;

@property (nonatomic , strong) NSArray <NSNumber *>              * auditor1_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor2_set;
@property (nonatomic , strong) NSArray <NSNumber *>              * auditor3_set;

@end

NS_ASSUME_NONNULL_END
/*
{
   "id": 7,
   "goods_name": "低钠食用盐",
   "specoption_set": [],
   "play_unit": "箱",
   "image": "http://qny.chimprove.top/1592534782雪天盐主图70079.png",
   "batch_set": [
     {
       "id": 6,
       "count": 1,
       "product_date": "2020-06-10",
       "live_time": 365,
       "expire_date": "2021-06-09"
     }
   ],
   "create_time": "2020-06-25 17:09:56",
   "check_time": "",
   "finish_time": "",
   "pay_time": "",
   "recive_time": "",
   "refuse_reason": "",
   "remark": "Ooo",
   "update_time": "2020-06-27T11:29:37.273208",
   "order_num": "MB0000000007",
   "back_reason": "临期退货",
   "amount": 1,
   "total_play_price": 1000,
   "play_price": 1000,
   "status": 11,
   "driver_info": {
     "name": "李师傅",
     "mobile": "12345675511"
   }
 }
*/
