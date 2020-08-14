//
//  CCModifyArddressTableViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "CCModityAddressViewController.h"
#import "BaseTableViewCell.h"
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCModifyArddressTableViewCell : BaseTableViewCell<CCMyAddressViewControllerDelegate>
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *addressLab;
@property (strong, nonatomic) UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;


@property (nonatomic,strong)  KKButton *modifyBtn;
+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
