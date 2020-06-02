

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
}
- (void)setModel:(BaseModel *)model {
    CCYouHuiQuan *mmmm = (CCYouHuiQuan *)model;
    self.modelddd = mmmm;
    
    self.subTitleLab.text=mmmm.name;

    self.dateLab.text=[NSString stringWithFormat:@"有效期：%@-%@",mmmm.begin_time,mmmm.end_time];
    if (mmmm.is_had) {
        [self.taskBtn setTitle:@"已使用" forState:UIControlStateNormal];
        self.bgImageView.image = IMAGE_NAME(@"优惠券背景灰");
    } else {
        [self.taskBtn setTitle:@"立即领取" forState:UIControlStateNormal];
        self.bgImageView.image = IMAGE_NAME(@"优惠券背景");
    }
    if (mmmm.use_selfimage) {
        [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:mmmm.selfimage] placeholderImage:IMAGE_NAME(@"")];
    }
    if (mmmm.types == 0) {
        self.titleLab.text = [NSString stringWithFormat:@"￥%@",mmmm.cut];
    } else {
        self.titleLab.text = [NSString stringWithFormat:@"%@折",mmmm.discount];
    }
}
- (IBAction)taskBtn:(UIButton *)sender {
    NSDictionary *params = @{};
    NSString *path =[NSString stringWithFormat:@"/app0/coupon/%ld/",self.modelddd.ccid];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
//            [kNotificationCenter postNotificationName:@"refreshYouHuiQuan" object:nil];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 137;
}
@end
