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
#import "CCActiveListMdoel.h"
#import "GBTagListView2.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTeTableViewCell : BaseTableViewCell
@property (nonatomic, strong)CCGoodsDetail *model;
@property (nonatomic, weak) id<KKCommonDelegate>delegate;
@property (nonatomic, weak) IBOutlet UIImageView  *headImage;
@property (nonatomic, weak)IBOutlet UILabel  *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel  *priceLbel;
@property (weak, nonatomic) IBOutlet UILabel *deletelab;
@property (strong,nonatomic) CCActiveListMdoel *activeModel;
@property (strong, nonatomic) UILabel *manjianLab; //  
@property (weak, nonatomic) IBOutlet UIImageView *lineView;

@property (nonatomic,weak)IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceBottomConstraint;
@property (weak, nonatomic) IBOutlet GBTagListView2 *tagContentView;
@property (assign, nonatomic) BOOL isTejia; // 
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
