//
//  CCReturnGoodsDetailHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/9.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCReturnGoodsDetailHeadView.h"

@implementation CCReturnGoodsDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    self.backgroundColor = kMainColor;
    
    UIImageView *iconIamgeView4 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@"箱子拒绝图标"];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [self addSubview:iconIamgeView4];
    [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self).mas_offset(0);
        make.left.mas_equalTo(self).mas_offset(kWidth(248));
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(44);
    }];
    UILabel *taRendaiFusumTextLab2 = ({
        UILabel *view = [UILabel new];
        view.textColor =kWhiteColor;
        view.font = STFont(15);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.numberOfLines = 0;
        view.text = @"退货申请已提交\n申请时间：2019/12/20  08:00";
        view ;
    });
    [self addSubview:taRendaiFusumTextLab2];
    [taRendaiFusumTextLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(kWidth(238), 84));
        make.centerY.mas_equalTo(self).mas_offset(0);
    }];
    
    
}
@end
