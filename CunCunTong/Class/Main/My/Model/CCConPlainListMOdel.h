//
//  CCConPlainListMOdel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/7/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Child_order_setItem :NSObject
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , assign) NSInteger              play_price;
@property (nonatomic , assign) NSInteger              total_play_price;
@property (nonatomic , assign) NSInteger              amount;
@property (nonatomic , copy) NSString              * unit;
@property (nonatomic , copy) NSString              * goods_name;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) NSArray <NSString *>              * specoption_set;

@end
@interface CCConPlainListMOdel : BaseModel
@property (nonatomic , assign) NSInteger              ccid;
@property (nonatomic , copy) NSString              * reason;
@property (nonatomic , copy) NSString              * order_num;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * check_time;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * info;
@property (nonatomic , strong) NSArray <Child_order_setItem *>              * child_order_set;
@property (nonatomic , strong) NSArray <NSString *>              * photo_set;
@property (nonatomic , copy) NSString              * return_msg;
@end

NS_ASSUME_NONNULL_END
/* {
           "id": 1,
           "reason": "假货",
           "order_num": "MCP0000000001",
           "create_time": "2020-07-01 19:37:04",
           "check_time": "",
           "status": 0,
           "info": "",
           "child_order_set": [
               {
                   "id": 47,
                   "order_num": "MOS0000000047",
                   "play_price": 3000.0,
                   "total_play_price": 3000.0,
                   "amount": 1,
                   "unit": "箱",
                   "goods_name": "红管唇釉丝绒哑光口红",
                   "image": "http://qny.chimprove.top/1592825033主486609.png",
                   "specoption_set": [
                       "#400"
                   ]
               },
               {
                   "id": 48,
                   "order_num": "MOS0000000048",
                   "play_price": 3000.0,
                   "total_play_price": 6000.0,
                   "amount": 2,
                   "unit": "箱",
                   "goods_name": "红管唇釉丝绒哑光口红",
                   "image": "http://qny.chimprove.top/1592825043主418234.png",
                   "specoption_set": [
                       "#205"
                   ]
               },
               {
                   "id": 49,
                   "order_num": "MOS0000000049",
                   "play_price": 1000.0,
                   "total_play_price": 1000.0,
                   "amount": 1,
                   "unit": "箱",
                   "goods_name": "低钠食用盐",
                   "image": "http://qny.chimprove.top/1592534782雪天盐主图70079.png",
                   "specoption_set": []
               }
           ],
           "photo_set": [
               "http://qny.chimprove.top/20200701073643_complaint",
               "http://qny.chimprove.top/20200701073652_complaint"
           ],
           "return_msg": ""
       }**/
