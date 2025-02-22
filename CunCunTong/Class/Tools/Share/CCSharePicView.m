//
//  CCSharePicView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "CCSharePicView.h"
#import "NKAlertView.h"
#import <Photos/Photos.h>
@implementation CCSharePicView


- (void)setupUI {
//    [CCTools sharedInstance] addShadowToView:self withColor:
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;

    // shop_invite_icon
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"详情页图片"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.clipsToBounds = YES;
    [self addSubview:imgView];
    imgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - (65));
    self.coverImage = imgView;
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = @"Restaurant";
    titleLab.textColor = COLOR_333333;
    titleLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLab];
    titleLab.frame = CGRectMake(10, CGRectGetHeight(imgView.frame)+10, CGRectGetWidth(self.frame), 15);
    self.titleLab = titleLab;
    UILabel *selectLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_999999;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:selectLab];
    [selectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(17);
    }];
    self.subLab = selectLab;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.tag = 12;
    [rightBtn setImage:IMAGE_NAME(@"下载保存按钮") forState:UIControlStateNormal];
    [rightBtn setTitleColor:NKColorWithRGB(0xFED953) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake((CGRectGetWidth(self.frame) - 37), CGRectGetHeight(self.frame)-35, 22, 19);
}

- (void)botBtnClick:(UIButton *)btn
{
//    NKAlertView *alertView = (NKAlertView *)self.superview;
//    [alertView hide];
    if (btn.tag == 11) {
        
    }else
    {
//        ALAuthorizationStatus author = [ALAssetsLibraryauthorization Status];
//        if (author == kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
//            //无权限
//        }
//        typedef enum {
//            kCLAuthorizationStatusNotDetermined = 0, // 用户尚未做出选择这个应用程序的问候
//            kCLAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
//            kCLAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
//            kCLAuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据} CLAuthorizationStatus;
//        }
        [CCTools srh_saveImage:self.coverImage.image completionHandle:^(NSError * _Nonnull aaa, NSString * _Nonnull bbb) {
            if (bbb.length > 0) {
                [MBManager showBriefAlert:@"图片已保存到本地相册"];
            }
        }];
    }
}

- (void)setModel:(CCGoodsDetailInfoModel *)model {
    _model = model;
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:_model.goodsimage_set[0]]
                       placeholderImage:IMAGE_NAME(@"")];
    self.titleLab.text = _model.goods_name;
    NSString *pricestr = _model.promote == nil ? STRING_FROM_0_FLOAT(_model.play_price):STRING_FROM_0_FLOAT(_model.promote.now_price);
    if (self.model.promote !=nil && self.model.promote.types == 2) {
         pricestr = STRING_FROM_0_FLOAT(self.model.play_price);
     }
    NSString *price = [NSString stringWithFormat:@"￥%@",pricestr];
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:krgb(255,69,4)}];
    NSMutableAttributedString *nameString2 = [[NSMutableAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:21],NSForegroundColorAttributeName:krgb(255,69,4)}];
    
    [nameString appendAttributedString:nameString2];
    if (_model.promote.old_price) {
        NSAttributedString *countString = [[NSAttributedString alloc] initWithString:@" 原价：" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999}];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:STRING_FROM_0_FLOAT(_model.promote.old_price) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:COLOR_999999,NSStrikethroughColorAttributeName:COLOR_999999,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid)}];
        [nameString appendAttributedString:countString];
        [nameString appendAttributedString:attrStr];
    }
    self.subLab.attributedText = nameString;
}

@end
