//
//  CCModifyArddressTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCModifyArddressTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *addressLab;
@property (strong, nonatomic) UILabel *numberLab;


@property (nonatomic,strong)  KKButton *modifyBtn;
+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
