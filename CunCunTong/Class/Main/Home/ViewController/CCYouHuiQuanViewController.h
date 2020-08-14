//
//  CCYouHuiQuanViewController.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCYouHuiQuanViewController : CCBaseTableViewController
- (instancetype)initWithCoupon_set:(NSArray *)coupon_set;
@property (strong, nonatomic) NSArray *coupon_setArray;   //
@property (assign, nonatomic) NSInteger orderID;    //
/*
 *    block
 */
@property (copy, nonatomic) void(^blackCoupon_id)(NSString *coupon_id);
@property (assign, nonatomic) BOOL isOrderVc; // 

@end

NS_ASSUME_NONNULL_END
