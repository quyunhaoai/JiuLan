//
//  CCOrderSelectView.h
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CCMyGoodsList.h"
#import "PPNumberButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCOrderSelectView : CCBaseView
/** b */
@property (copy, nonatomic) void (^sureBlack)(NSInteger count,NSInteger sku_id);
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *pinTypeLab;
@property (strong, nonatomic) UILabel *pinpaiLab;
@property (strong, nonatomic) UIImageView *imagViewImage; //
@property (strong, nonatomic) UILabel *guigeLab; //
@property (strong, nonatomic) UILabel *inGoodLab; //
@property (strong, nonatomic) UILabel *salesLab; //
@property (strong, nonatomic) UILabel *kucunLab; //  
@property (strong, nonatomic) PPNumberButton *numberButton;
@property (strong, nonatomic) UILabel *untilLab; //  







@property (strong,nonatomic) CCMyGoodsList *model;
@end

NS_ASSUME_NONNULL_END
