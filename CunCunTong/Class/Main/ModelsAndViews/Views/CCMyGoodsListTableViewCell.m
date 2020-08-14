
//
//  CCMyGoodsListTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMyGoodsListTableViewCell.h"

@implementation CCMyGoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.bgView setCornerRadius:5 withShadow:YES withOpacity:0.5];
    self.inNumberLab.textColor = krgb(239,122,64);
    self.buyNumber.textColor = krgb(239,122,64);
    
    self.button1.layer.cornerRadius = 13;
    self.button2.layer.cornerRadius = 13;
    self.outGoodsBtn.layer.cornerRadius = 13;
    [self.outGoodsBtn setBackgroundColor:kWhiteColor];
    [self.button1 setBackgroundColor:kWhiteColor];
    [self.button2 setBackgroundColor:kWhiteColor];
    [self.outGoodsBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
    [self.button1 setTitleColor:kTipYellowCOLOR forState:UIControlStateNormal];
    [self.button2 setTitleColor:kMainColor forState:UIControlStateNormal];
    [[CCTools sharedInstance] addborderToView:self.outGoodsBtn width:1 color:kGrayColor];
    [[CCTools sharedInstance]   addborderToView:self.button2 width:1 color:kMainColor];
    [[CCTools sharedInstance] addborderToView:self.button1 width:1 color:kTipYellowCOLOR];
    self.textField1.layer.borderColor = kRedColor.CGColor;
    self.textField1.layer.borderWidth = 0.5;
    self.textField1.layer.cornerRadius = 2;
    self.textField2.layer.borderColor = kRedColor.CGColor;
    self.textField2.layer.borderWidth = 0.5;
    self.textField2.layer.cornerRadius = 2;
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsImageView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 171;
}
- (void)setModel:(BaseModel *)model {
    CCMyGoodsList *mmm = (CCMyGoodsList *)model;
    self.moddd = mmm;
    self.goodsTitle.text = mmm.goods_name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:mmm.image] placeholderImage:IMAGE_NAME(@"")];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品类：%@",mmm.category]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

           // text-style1
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, mmm.category.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, mmm.category.length)];
    self.pinTypeLab.attributedText = attributedString;
           //
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"品牌：%@",mmm.brand]];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

           // text-style1
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3,  mmm.brand.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, mmm.brand.length)];
    self.pinpaiLab.attributedText = attributedString1;
    if (mmm.specoption_set.count) {
        NSMutableString *string = [[NSMutableString alloc] init];
        if (mmm.specoption_set.count == 1) {
            [string appendString:mmm.specoption_set[0]];
        } else {
            [string appendString:mmm.specoption_set[0]];
            for (NSString *item in mmm.specoption_set) {
                if ([item isEqual:string]) {
                    continue;
                }
                [string appendFormat:@",%@",item];
            }
        }
               //500-ml
        NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"规格：%@",string]];
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 3)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 3)];

               //500-ml text-style1
        [attributedString2 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(3, string.length)];
        [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(3, string.length)];
        self.gugeLab.attributedText = attributedString2;
    }
           //80
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"进货价：%ld",mmm.play_price]];
    [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 4)];
           [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 4)];

           //80 text-style1
    [attributedString3 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",mmm.play_price].length)];
    [attributedString3 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(4, [NSString stringWithFormat:@"%ld",mmm.play_price].length)];
           self.inPriceLab.attributedText = attributedString3;
           
           //100
    NSMutableAttributedString *attributedString4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"建议零售价：%ld",mmm.retail_price]];
           [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(0, 6)];
           [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 6)];

           //100 text-style1
    [attributedString4 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:13.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",mmm.retail_price].length)];
    [attributedString4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:36.0f/255.0f green:149.0f/255.0f blue:143.0f/255.0f alpha:1.0f] range:NSMakeRange(6, [NSString stringWithFormat:@"%ld",mmm.retail_price].length)];
    self.salesPriceLab.attributedText = attributedString4;
    
}
- (void)setIsKUCun:(BOOL)isKUCun {
    _isKUCun = isKUCun;
    if (_isKUCun) {
        self.button2.hidden = NO;
        self.button1.hidden = NO;
        self.outGoodsBtn.hidden = NO;
        self.meddilLine.hidden = YES;
        self.inNumberLab.hidden = YES;
        self.buyNumber.hidden = YES;
        self.bottomTitle2Lab.hidden = YES;
        self.botttomTitleLab.hidden = YES;
    } else {
        self.button2.hidden = YES;
        self.button1.hidden = YES;
        self.outGoodsBtn.hidden = YES;
        self.meddilLine.hidden = NO;
        self.inNumberLab.hidden = NO;
        self.buyNumber.hidden = NO;
        self.bottomTitle2Lab.hidden = NO;
        self.botttomTitleLab.hidden = NO;
    }
}
- (IBAction)buttonAction:(UIButton *)sender {
    if (sender.tag == 11) {//补货
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
            [self.delegate clickButtonWithType:1 item:self.moddd];
        }
    }else  if (sender.tag == 13) {//补货
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
            [self.delegate clickButtonWithType:3 item:self.moddd];
        }
    } else {//销出
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
            [self.delegate clickButtonWithType:2 item:self.moddd];
        }
    }
}

- (IBAction)changeButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        self.moddd.up_warn = self.textField1.text;
        self.moddd.down_warn = self.textField2.text;
        [self.delegate clickButtonWithType:0 item:self.moddd];
    }
}

/*@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;

@property (weak, nonatomic) IBOutlet UILabel *pinTypeLab;

@property (weak, nonatomic) IBOutlet UILabel *pinpaiLab;
@property (weak, nonatomic) IBOutlet UILabel *gugeLab;
@property (weak, nonatomic) IBOutlet UILabel *inPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *salesPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *inNumberLab;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;

@property (weak, nonatomic) IBOutlet UILabel *botttomTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitle2Lab;
 {
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
 },**/
@end
