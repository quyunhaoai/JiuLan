//
//  CCMyGoodsListTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"
//#import "CCKuCunGoodsList.h"
#import "CCNearWarnModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCKuCunGoodsListTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *pinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *pinpaiLab;
@property (weak, nonatomic) IBOutlet UILabel *gugeLab;
@property (weak, nonatomic) IBOutlet UILabel *inPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *salesPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *jianyilingshouLab;

@property (weak, nonatomic) IBOutlet UILabel *inNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;

@property (weak, nonatomic) IBOutlet UILabel *botttomTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitle2Lab;


//@property (strong, nonatomic) CCKuCunGoodsList *model;   
@property (strong, nonatomic) CCNearWarnModel *warnModel;
@property (weak, nonatomic) IBOutlet UILabel *kuCunNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *kucunNumber3;
@property (weak, nonatomic) IBOutlet UILabel *kucunNumber4;


+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
