//
//  BottomAlert2Contentview.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCGoodsDetailInfoModel.h"
#import "GBTagListView.h"
#import "PPNumberButton.h"
#import "CCChexiaoListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BottomAlert2Contentview : UIView
-(instancetype)initWithFrame:(CGRect)frame withShowSure:(BOOL)showSure;
@property (nonatomic,strong)CCGoodsDetailInfoModel *model;
@property (strong, nonatomic) CCChexiaoListModel *cccModel;

@property (assign, nonatomic) BOOL isChexiao;
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^blockMothed)(void);
/*
 *  black block
 */
@property (copy, nonatomic) void(^blackSelect)(NSString *str);
@property (assign, nonatomic) BOOL showSure; //
@property (assign, nonatomic) BOOL isSureOrder; //
@property (strong, nonatomic) PPNumberButton *numberButton;
@end

NS_ASSUME_NONNULL_END
