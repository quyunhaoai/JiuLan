//
//  CCEverDayTeTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
#import "CCGoodsDetail.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTeTableViewCell : BaseTableViewCell
@property (nonatomic, strong)CCGoodsDetail *model;

@property (nonatomic, weak) IBOutlet UIImageView  *headImage;
@property (nonatomic, weak)IBOutlet UILabel  *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel  *priceLbel;
@property (weak, nonatomic) IBOutlet UILabel *deletelab;


@property (nonatomic,weak)IBOutlet UIButton *addBtn;

+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
