//
//  CCModifyArddressTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCModifyArddressTableViewCell.h"
#import "CCModifyArddress.h"
@implementation CCModifyArddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];

    self.numberLab.textColor = COLOR_333333;
    self.addressLab.textColor = COLOR_666666;
    self.modifyBtn.hidden = NO;
    
//    self.nameLab.text = @"王强";
//    self.numberLab.text = @"13145217111";
//    self.addressLab.text = @"河南省郑州市二七区长江路街道长江路与连云路交叉口正商城2号楼";
}
- (void)setModel:(BaseModel *)model{
    CCModifyArddress *modelddd = (CCModifyArddress *)model;
    self.nameLab.text = modelddd.name;
    self.numberLab.text = modelddd.mobile;
    self.addressLab.text = modelddd.address;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setupUI {
//    UIImageView *imageBgView = ({
//        UIImageView *view = [UIImageView new];
//        view.contentMode = UIViewContentModeScaleAspectFill ;
//        view.layer.masksToBounds = YES ;
//        view.userInteractionEnabled = YES ;
//        [view setImage:IMAGE_NAME(@"收货地址背景")];
//
//        view;
//    });
//
//    [self addSubview:imageBgView];
//    [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self);
//    }];
//    UIImageView *areaIcon = ({
//        UIImageView *view = [UIImageView new];
//        view.contentMode = UIViewContentModeScaleAspectFill ;
//        view.layer.masksToBounds = YES ;
//        view.userInteractionEnabled = YES ;
//        [view setImage:IMAGE_NAME(@"收货地址图标-1")];
//
//        view;
//    });
//
//    [self addSubview:areaIcon];
//    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).mas_offset(10);
//        make.size.mas_equalTo(CGSizeMake(17, 24));
//        make.centerY.mas_equalTo(self.mas_centerY);
//    }];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(17);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;

    });
    [self addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(77, 14));
        make.top.mas_equalTo(self).mas_offset(10);
    }];
    self.nameLab = nameLab;
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 2;
        view ;
    });
    [self addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(247, 34));
        make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
    }];
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = STFont(12);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    
    [self addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLab.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(nameLab).mas_offset(0);
    }];
    self.addressLab = addressLab;
    self.numberLab = mobleNumberLab;
//    [self addSubview:self.modifyBtn];
//    [self.modifyBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self).mas_offset(-5);
//        make.size.mas_equalTo(CGSizeMake(77, 33));
//        make.bottom.mas_equalTo(self).mas_offset(-5);
//    }];
//    [self.modifyBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
}

- (KKButton *)modifyBtn {
    if (!_modifyBtn) {
        _modifyBtn = ({
            KKButton *view = [KKButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"修改" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_13];
            [view setTitleColor:COLOR_333333 forState:UIControlStateNormal];
            [view setImage:IMAGE_NAME(@"编辑图标") forState:UIControlStateNormal];
            view.userInteractionEnabled = YES;
            view.hidden = YES;
            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _modifyBtn;
}

- (void)addBtnClick:(UIButton *)btn {
//    CCModityAddressViewController *vc = [CCModityAddressViewController new];
//    vc.delegate = self;
//    [self.superview.viewController.navigationController pushViewController:vc animated:YES];
}
- (void)clickViewWithAddress:(NSString *)address moblieNumber:(NSString *)moblie name:(NSString *)name {
    self.addressLab.text = address;
    self.numberLab.text = moblie;
    self.nameLab.text = name;
}
+ (CGFloat)height {
    return 85.0f;
}
@end
