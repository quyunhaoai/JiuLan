//
//  CCGoodsSelectModelTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCGoodsSelectModelTableViewCell : BaseTableViewCell
+ (CGFloat)height;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *goodsGuiGelab;
@property (weak, nonatomic) IBOutlet UILabel *goodsDanwLab;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumberlabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;



@end

NS_ASSUME_NONNULL_END
