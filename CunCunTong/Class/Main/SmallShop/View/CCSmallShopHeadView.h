//
//  CCSmallShopHeadView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CClittleInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCSmallShopHeadView : CCBaseView
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^clcikView)(NSInteger tag);
@property (strong,nonatomic) CClittleInfoModel *model;
@end

NS_ASSUME_NONNULL_END
