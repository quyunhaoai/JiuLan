//
//  SH_MallSubclassificationSelectView.h
//  XiYuanPlus
//
//  Created by xy on 2018/4/10.
//  Copyright © 2018年 Hoping. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MallSelectedType) {
    SelectedTypeComprehensive,//综合
    SelectedTypeSalesVolumeUp,//销量升
    SelectedTypeSalesVolumeDown,//销量降
    SelectedTypePriceUp,//价格升
    SelectedTypePriceDown,//价格降
    MallSelectedTypeShaiXuan,//筛选
};

@interface SH_MallSubclassificationSelectView : UIView
@property (assign, nonatomic) MallSelectedType selectedType;

/*
 *  function block
 */

@property (copy, nonatomic) void(^selctButtonClickBlock)(MallSelectedType selectedType);

@end
