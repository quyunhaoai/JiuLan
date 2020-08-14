//
//  CCMyOrderModelTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CCMyOrderModel.h"
#import "CCBackOrderListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCSelectGoodsTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *contentbgView;
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *subTypeLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *singePriceLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLab;
@property (weak, nonatomic) IBOutlet UILabel *salesTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (strong, nonatomic) NSIndexPath *index; 


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeft;

@property (strong,nonatomic) CCMyOrderModel *mainOrderModel;
@property (strong,nonatomic) Sku_order_setItem *skuModel;
@property (strong,nonatomic) Goods_order_setItem *goodsModel;
@property (strong,nonatomic) CCBackOrderListModel *backgoodsModel;

@property (weak, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *downDateLab;
@property (weak, nonatomic) id<KKCommonDelegate>delegate;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
