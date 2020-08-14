//
//  CCBalanceTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBalanceTableViewCell.h"
#import "CCBalance.h"
@implementation CCBalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.textColor = COLOR_333333;
    self.subtitleLab.textColor = COLOR_999999;
    //UIFont(name: "DIN-Medium", size: 19.0)
    [self.priceLab setFont:[UIFont fontWithName:@"DIN-Medium" size:19]];
    self.priceLab.textColor = COLOR_333333;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {
    CCBalance *mmmm =  (CCBalance *)model;
    // # 0:微信充值，1：支付宝充值，2：银联充值，3：退货充值，4：下单付款，5：车销付款
    switch (mmmm.types) {
        case 0:
            self.titleLab.text = @"微信充值";
            self.logoimage.image = IMAGE_NAME(@"微信图标");
            self.priceLab.text = [NSString stringWithFormat:@"+%ld",mmmm.price];
            break;
        case 1:
            self.titleLab.text = @"支付宝充值";
            self.logoimage.image = IMAGE_NAME(@"支付宝图标");
            self.priceLab.text = [NSString stringWithFormat:@"+%ld",mmmm.price];
            break;
        case 2:
            self.titleLab.text = @"银联充值";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"+%ld",mmmm.price];
            break;
        case 3:
            self.titleLab.text = @"退货充值";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"+%ld",mmmm.price];
            break;
        case 4:
            self.titleLab.text = @"下单付款";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"-%ld",mmmm.price];
            break;
        case 5:
            self.titleLab.text = @"车销付款";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"-%ld",mmmm.price];
            break;
        case 6://提现
            self.titleLab.text = @"提现";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"-%ld",mmmm.price];
            break;
        case 7://临期活动补差价
            self.titleLab.text = @"临期活动补差价";
            self.logoimage.image = IMAGE_NAME(@"其他方式充值图标");
            self.priceLab.text = [NSString stringWithFormat:@"-%ld",mmmm.price];
            break;
        default:
            break;
    }

    self.subtitleLab.text = mmmm.finish_time;

}
+ (CGFloat)height {
    return 58.f;
}
@end
