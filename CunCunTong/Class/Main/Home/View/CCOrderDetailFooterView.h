//
//  CCOrderDetailFooterView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "CCOrderDatileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDetailFooterView : CCBaseView
@property (nonatomic,strong) CCOrderDatileModel *model;

@property (strong, nonatomic) UILabel *priceLab;
@property (strong, nonatomic) UILabel *cutLab;
@property (strong, nonatomic) UILabel *sumLab;


@end

NS_ASSUME_NONNULL_END
