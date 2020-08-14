//
//  CCOrderSelectView.m
//  CunCunDriverEnd
//
//  Created by GOOUC on 2020/5/22.
//  Copyright © 2020 GOOUC. All rights reserved.
//


#import "CCOrderSelectView.h"
#import "NKAlertView.h"

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation CCOrderSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 17, 2, 12)];
        [self addSubview:line];
        line.backgroundColor = kMainColor;
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentLeft;
        titleLab.textColor = COLOR_333333;
        titleLab.font = [UIFont systemFontOfSize:13];
        titleLab.numberOfLines = 2;
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(10, 15, CGRectGetWidth(frame), 14);
        // shop_invite_icon
        self.titleLab = titleLab;
        UIView *line1 = [UIView new];
        line1.backgroundColor = UIColorHex(0xf7f7f7);
        [self addSubview:line1];
        [line1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(10);
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(7);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(kWidth(1));
        }];
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@" "];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        imgView.frame = CGRectMake(10,  CGRectGetMaxY(titleLab.frame) + 15, 55, 55);
        self.imagViewImage = imgView;
        UIView *line2 = [UIView new];
        line2.backgroundColor = UIColorHex(0xf7f7f7);
        [self addSubview:line2];
        [line2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(10);
            make.top.mas_equalTo(imgView.mas_bottom).mas_offset(7);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(kWidth(1));
        }];
        UILabel *nameLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:nameLab];
        [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(75);
            make.size.mas_equalTo(CGSizeMake(100, 12));
            make.top.mas_equalTo(imgView.mas_top).mas_offset(4);
        }];
        self.pinTypeLab = nameLab;
        UILabel *addressLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:addressLab];
        [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(75);
            make.size.mas_equalTo(CGSizeMake(100, 12));
            make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(4);
        }];
        self.pinpaiLab = addressLab;
        UILabel *mobleNumberLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:mobleNumberLab];
        [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(75);
            make.size.mas_equalTo(CGSizeMake(100, 12));
            make.top.mas_equalTo(addressLab.mas_bottom).mas_offset(4);
        }];
        self.guigeLab = mobleNumberLab;
        
        UILabel *nameLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:nameLab2];
        [nameLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(167);
            make.size.mas_equalTo(CGSizeMake(100, 12));
            make.top.mas_equalTo(imgView.mas_top).mas_offset(4);
        }];
        self.inGoodLab = nameLab2;
        UILabel *addressLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:addressLab2];
        [addressLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(167);
            make.size.mas_equalTo(CGSizeMake(247, 12));
            make.top.mas_equalTo(nameLab2.mas_bottom).mas_offset(4);
        }];
        self.salesLab = addressLab2;
        UILabel *mobleNumberLab2 = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        
        [self addSubview:mobleNumberLab2];
        [mobleNumberLab2 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(167);
            make.size.mas_equalTo(CGSizeMake(100, 12));
            make.top.mas_equalTo(addressLab2.mas_bottom).mas_offset(4);
        }];
        self.kucunLab = mobleNumberLab2;
        
        UILabel *nameLab3 = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:nameLab3];
        [nameLab3 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(200, 12));
            make.top.mas_equalTo(imgView.mas_bottom).mas_offset(14);
        }];
    
        self.untilLab = nameLab3;
        UILabel *nameLab4 = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_999999;
            view.font = STFont(11);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
        [self addSubview:nameLab4];
        [nameLab4 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(10);
            make.size.mas_equalTo(CGSizeMake(77, 12));
            make.top.mas_equalTo(nameLab3.mas_bottom).mas_offset(14);
        }];
        //
        NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:@"销出数量："];
        [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f] range:NSMakeRange(0, 5)];
        [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:27.0f/255.0f green:27.0f/255.0f blue:27.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
        nameLab4.attributedText = attributedString4;
        
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(10, MaxY(nameLab4.frame), 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        numberButton.editing = NO;
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%f",number);
        };
        [self addSubview:numberButton];
        [numberButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(nameLab4.mas_right).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(90, 20));
            make.top.mas_equalTo(nameLab3.mas_bottom).mas_offset(10);
        }];
        self.numberButton = numberButton;
        
        UIView *botVIew = [[UIView alloc] init];
        [self addSubview:botVIew];
        botVIew.frame = CGRectMake(0, CGRectGetHeight(frame) - 39, CGRectGetWidth(frame), 39);
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = krgb(255,157,52);
        leftBtn.tag = 11;
        [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        [leftBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:leftBtn];
        leftBtn.frame = CGRectMake(0, 0, (CGRectGetWidth(frame) ) * 0.5, 39);
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = kMainColor;
        rightBtn.tag = 12;
        [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [rightBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:rightBtn];
        rightBtn.frame = CGRectMake((CGRectGetWidth(frame)) * 0.5, 0, (CGRectGetWidth(frame)) * 0.5, 39);
    }
    return self;
}
- (void)setModel:(CCMyGoodsList *)model {
    _model = model;
    self.titleLab.text = _model.goods_name;

    [self.imagViewImage sd_setImageWithURL:[NSURL URLWithString:_model.image]];
      NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品类：%@",_model.category]];
       [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, _model.category.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, _model.category.length)];
       self.pinTypeLab.attributedText = attributedString;
       //
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品牌：%@",_model.brand]];
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
       [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

       // text-style1
       [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3,  _model.brand.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, _model.brand.length)];
       self.pinpaiLab.attributedText = attributedString1;
    if (_model.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        [string appendString:_model.specoption_set[0]];
           //500-ml
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",string]];
           [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
           [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];
           //500-ml text-style1
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, string.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, string.length)];
           self.guigeLab.attributedText = attributedString2;
    }
       //80
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",(long)_model.play_price]];
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
       [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

       //80 text-style1
       [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.play_price].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",(long)_model.play_price].length)];
       self.inGoodLab.attributedText = attributedString3;
       
       //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"零售单位：%@",_model.play_unit]];
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 5)];
       [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];

       //100 text-style1
       [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_model.play_unit].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(5, [NSString stringWithFormat:@"%@",_model.play_unit].length)];
       self.untilLab.attributedText = attributedString4;
       
       //120
    NSMutableAttributedString *attributedString5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"建议零售价：%ld",(long)_model.retail_price]];
       [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 6)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 6)];

       //120 text-style1
    [attributedString5 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_model.retail_price].length)];
       [attributedString5 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",(long)_model.retail_price].length)];
       self.salesLab.attributedText = attributedString5;
//    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:@"参数：默认"];
//    [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:14.0f] range:NSMakeRange(0, 5)];
//    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 5)];
//    self.untilLab.attributedText = attributedString3;
}/*      {
  "id": 9,
  "goods_name": "包包女2020新款夏季韩版百搭小香风单肩链条包",
  "image": "http://qny.chimprove.top/1592559148O1CN01ZKGERn1uZPBGgR5Tm_!!0-item_pic91139.png",
  "bar_code": "111111",  # 条形码
  "category": "箱包",  # 分类
  "brand": "金狐狸",  # 品牌
  "specoption_set": [  # 规格数组
    "粉红色"
  ],
  "play_unit": "箱",  # 进货单位
  "play_price": 1000,  # 进货单价
  "retail_unit": "箱",  # 零售单位
  "retail_price": 1200,  # 零售单价
  "count": 30,  #types=0时，进货数量，1时销售数量，2时库存数量
  "count_price": 30000  # types0时进货金额，1时销售金额，2时没有任何意义
}**/
- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 11) {
        
    }else
    {
        if (self.sureBlack) {
            self.sureBlack(self.numberButton.currentNumber,self.model.id);
        }
    }
}
@end
