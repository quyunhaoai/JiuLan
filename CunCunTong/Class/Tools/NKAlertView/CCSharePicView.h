//
//  CCSharePicView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CCGoodsDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCSharePicView : CCBaseView
@property (strong,nonatomic) CCGoodsDetailInfoModel *model;
@property (strong, nonatomic) UIImageView *coverImage;
@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UILabel *subLab;  



@end

NS_ASSUME_NONNULL_END
