//
//  CCMessageModel.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCMessageModel : BaseModel
@property (assign, nonatomic) NSInteger id;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *create_time;
@property (assign, nonatomic) NSInteger types;    //
@property (nonatomic,copy) NSString *m_back_order_id;  //
@property (nonatomic,copy) NSString *m_total_order_id;  //
@property (nonatomic,copy) NSString *send_order_id;  //
//@property (nonatomic , assign) NSInteger              id;
//@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , assign) BOOL              readed;
@property (nonatomic , copy) NSString              * title;
//@property (nonatomic , copy) NSString              * message;
//@property (nonatomic , assign) NSInteger              types;
@property (nonatomic , assign) NSInteger              m_total_order;
@property (nonatomic , assign) NSInteger              market_charge;
@property (nonatomic , assign) NSInteger              promote_id;
@property (nonatomic , assign) NSInteger              reduce_id;
@property (nonatomic , assign) NSInteger              notice_id;
@property (nonatomic , copy) NSString              * image;
@end

NS_ASSUME_NONNULL_END
