//
//  CCOrderDetailHeadView.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCOrderDetailHeadView : CCBaseView
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *addressLab;
@property (strong, nonatomic) UILabel *numberLab;
@property (strong, nonatomic) UILabel *wuliuLab;  

@property (nonatomic,copy) NSString *wuliuInfo;  
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^ClickBack)(NSInteger type);

@end

NS_ASSUME_NONNULL_END
