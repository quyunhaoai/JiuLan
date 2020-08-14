//
//  CCReturnGoodsFooterView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCReturnGoodsFooterView : CCBaseView
@property (nonatomic,strong) UIButton *sendBtn;
@property (strong, nonatomic) NSMutableArray *photoArray;
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^blackBlock)(NSMutableArray *photoArray);


@end

NS_ASSUME_NONNULL_END
