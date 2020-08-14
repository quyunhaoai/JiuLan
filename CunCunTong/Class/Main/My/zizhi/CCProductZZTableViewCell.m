
//
//  CCProductZZTableViewCell.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCProductZZTableViewCell.h"

@implementation CCProductZZTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
    self.contentView.backgroundColor = kWhiteColor;
    
}
- (void)setupUI {
    [self.contentView removeAllSubviews];
    UIView *line = [[UIView alloc] init];
    [self.contentView addSubview:line];
    line.backgroundColor = UIColorHex(0xf7f7f7);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view ;
    });
    [self addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(Window_W-106-80, 14));
        make.top.mas_equalTo(self).mas_offset(10+10);
    }];
    self.nameLab = nameLab;
    UILabel *addressLab = ({
        UILabel *view = [UILabel new];
        view.textColor =krgb(255,157,52);
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view.numberOfLines = 1;
        view.userInteractionEnabled = YES;
        view.hidden = YES;
        view ;
    });
    [self addSubview:addressLab];
    [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-116);
        make.size.mas_equalTo(CGSizeMake(80, 14));
        make.top.mas_equalTo(self).mas_offset(10 + 10);
    }];
    self.subLab = addressLab;
    
    UIView *line1 = [[UIView alloc] init];
    [self.contentView addSubview:line1];
    line1.backgroundColor = UIColorHex(0xf7f7f7);
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(addressLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(1);
    }];
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"删除" forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_13];
        [view setTitleColor:kRedColor forState:UIControlStateNormal];
        [view setUserInteractionEnabled:YES];
        view.tag = 100;
        [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self.contentView addSubview:sureBtn];
    self.deleteBtn = sureBtn;
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(43);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(addressLab.mas_centerY).mas_offset(0);
    }];
    UIButton *sureBtn1 = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"修改" forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_13];
        [view setUserInteractionEnabled:YES];
        [view setTitleColor:krgb(255,157,52) forState:UIControlStateNormal];
        view.tag = 101;
        [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self.contentView addSubview:sureBtn1];
    [sureBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(43);
        make.right.mas_equalTo(sureBtn.mas_left).mas_offset(-10);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(addressLab.mas_centerY).mas_offset(0);
    }];
    self.changeBtn = sureBtn1;
    
    PYPhotosView *photosView = [PYPhotosView photosView];
    photosView.photoMargin = 10;
    photosView.photoWidth = (Window_W-40) /3;
    photosView.photoHeight = (Window_W-40) /3;
    photosView.x = 10;
    photosView.y = 54;
    // 3. 添加photosView
    [self.contentView addSubview:photosView];
    self.photosView = photosView;
}

- (void)commentBtnClick:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpBtnClicked:andModel:)]) {
        if (self.businessModel) {
            [self.delegate jumpBtnClicked:button andModel:self.businessModel];
        } else {
            [self.delegate jumpBtnClicked:button andModel:self.model];
        }
    }
}

- (void)setModel:(CCProductZZModel *)model {
    _model = model;
    self.nameLab.text = [NSString stringWithFormat:@"商品名称：%@",_model.center_goods_name];
    NSMutableArray *arr = [NSMutableArray array];
    for (Centergoodsqualifyphoto_setItem *model in _model.centergoodsqualifyphoto_set) {
        [arr addObject:model.image];
    }
    self.photosView.thumbnailUrls = arr;
}

- (void)setBusinessModel:(CCBusinessZZModel *)businessModel {
    _businessModel = businessModel;
    self.nameLab.text = [NSString stringWithFormat:@"资质名称:%@",_businessModel.name];
    NSMutableArray *arr = [NSMutableArray array];
    for (Supplierqualifyphoto_setItem *model in _businessModel.marketqualifyphoto_set) {
        [arr addObject:model.image];
    }
    self.photosView.thumbnailUrls = arr;
    self.photosView.size = [self.photosView sizeWithPhotoCount:arr.count photosState:1];
    self.photosView.x = 10;
    self.photosView.y = 54;
}
@end
