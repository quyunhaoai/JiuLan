

//
//  CCYouHuiQuanTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "CCYouHuiQuan.h"
#import "CCYouHuiQuanTableViewCell.h"

@implementation CCYouHuiQuanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgImageView.layer.cornerRadius = 5;
    self.bgImageView.layer.masksToBounds = YES;
}
- (void)setModel:(BaseModel *)model {
    CCYouHuiQuan *mmmm = (CCYouHuiQuan *)model;
    self.modelddd = mmmm;
    
    self.subTitleLab.text=mmmm.name;

    self.dateLab.text=[NSString stringWithFormat:@"有效期：%@至%@",mmmm.begin_time,mmmm.end_time];
    if (mmmm.is_had) {
        if (self.isActive || self.isOrderVc) {
            [self.taskBtn setTitle:@"立即使用" forState:UIControlStateNormal];
            self.bgImageView.image = IMAGE_NAME(@"优惠券背景");
        } else {
            [self.taskBtn setTitle:@"已领取" forState:UIControlStateNormal];
            [self.taskBtn setTitleColor:krgb(199,199,199) forState:UIControlStateNormal];
            self.bgImageView.image = IMAGE_NAME(@"优惠券背景灰");
        }
        
    } else {
        if (self.isOrderVc) {
            [self.taskBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        } else {
            [self.taskBtn setTitle:@"立即领取" forState:UIControlStateNormal];
        }
        self.bgImageView.image = IMAGE_NAME(@"优惠券背景");
    }
    if (mmmm.use_selfimage) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:mmmm.selfimage] placeholderImage:IMAGE_NAME(@"")];
    }
    if (mmmm.types == 0) {
        self.titleLab.text = [NSString stringWithFormat:@"￥%@",mmmm.cut];
    } else {
        mmmm.discount = [mmmm.discount stringByReplacingOccurrencesOfString:@".00" withString:@""];
        self.titleLab.text = [NSString stringWithFormat:@"%@折",mmmm.discount];
    }
}
- (void)setModelccc:(CCYouHuiQuan *)modelccc {
    _modelccc = modelccc;
    self.modelddd = _modelccc;
    self.subTitleLab.text=_modelccc.name;

    self.dateLab.text=[NSString stringWithFormat:@"有效期：%@至%@",_modelccc.begin_time,_modelccc.end_time];
    if (_modelccc.is_had) {
        if (self.isActive||self.isOrderVc) {
            [self.taskBtn setTitle:@"立即使用" forState:UIControlStateNormal];
            self.bgImageView.image = IMAGE_NAME(@"优惠券背景");
        } else {
            [self.taskBtn setTitle:@"已领取" forState:UIControlStateNormal];
            [self.taskBtn setTitleColor:krgb(199,199,199) forState:UIControlStateNormal];
            self.bgImageView.image = IMAGE_NAME(@"优惠券背景灰");
        }
        
    } else {
        if (self.isOrderVc) {
            [self.taskBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        } else {
            [self.taskBtn setTitle:@"立即领取" forState:UIControlStateNormal];
        }
        self.bgImageView.image = IMAGE_NAME(@"优惠券背景");
    }
    if (_modelccc.use_selfimage) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:_modelccc.selfimage] placeholderImage:IMAGE_NAME(@"")];
    }
    if (_modelccc.types == 0) {
        self.titleLab.text = [NSString stringWithFormat:@"￥%@",_modelccc.cut];
    } else {
        _modelccc.discount = [_modelccc.discount stringByReplacingOccurrencesOfString:@".00" withString:@""];
        self.titleLab.text = [NSString stringWithFormat:@"%@折",_modelccc.discount];
    }
}
- (IBAction)taskBtn:(UIButton *)sender {
    if (self.isOrderVc) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
            [self.delegate jumpBtnClicked:self.modelddd];
        }
    } else {
        if ([sender.titleLabel.text isEqualToString:@"立即领取"]) {
            NSDictionary *params = @{};
            NSString *path =[NSString stringWithFormat:@"/app0/coupon/%ld/",self.modelddd.ccid];
            [[STHttpResquest sharedManager] requestWithMethod:GET
                                                     WithPath:path
                                                   WithParams:params
                                             WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
                NSInteger status = [[dic objectForKey:@"errno"] integerValue];
                NSString *msg = [[dic objectForKey:@"errmsg"] description];
                if(status == 0){
                    [kNotificationCenter postNotificationName:@"refreshYouHuiQuan" object:nil];
                }else {
                    if (msg.length>0) {
                        [MBManager showBriefAlert:msg];
                    }
                }
            } WithFailurBlock:^(NSError * _Nonnull error) {
            }];
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
                [self.delegate jumpBtnClicked:self.modelddd];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
@end
