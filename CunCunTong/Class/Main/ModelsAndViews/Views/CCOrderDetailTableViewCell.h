//
//  CCOrderDetailTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CCOrderDatileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDetailTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imag;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;

@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;




@property (weak, nonatomic) IBOutlet UIButton *outBtn;
@property (strong,nonatomic) Goods_order_setItem *goodsModel;
@property (strong,nonatomic) Sku_order_setItem *skuModel;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
