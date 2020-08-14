//
//  CCShaiXuanGoodsView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCShaiXuanGoodsView : CCBaseView
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^blackID)(NSString *catedity1ID,NSString *catedity2ID,NSString *catedity3ID,NSString *pinPaiID);

@end

NS_ASSUME_NONNULL_END
