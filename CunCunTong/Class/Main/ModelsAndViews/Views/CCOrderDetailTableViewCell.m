//
//  CCOrderDetailTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCOrderDetailTableViewCell.h"
#import "CCReturnGoodsViewController.h"
@implementation CCOrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.outBtn.layer.cornerRadius = 5;
    self.outBtn.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:157.0f/255.0f blue:52.0f/255.0f alpha:1.0f] CGColor];
    self.outBtn.layer.borderWidth = 1;
    self.imag.layer.masksToBounds = YES;
    self.imag.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 113;;
}
- (IBAction)returnGoods:(id)sender {
    XYWeakSelf;
    NSDictionary *params = @{
    };
    NSString *path =  [NSString stringWithFormat:@"/app0/backorder/%ld/",self.skuModel.ccid];
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"errno"] integerValue];
        NSString *msg = [[dic objectForKey:@"errmsg"] description];
        if(status == 0){
            CCReturnGoodsViewController *vc = [CCReturnGoodsViewController new];
            vc.skuID =STRING_FROM_INTAGER(self.skuModel.ccid);
            [weakSelf.superview.viewController.navigationController pushViewController:vc animated:YES];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];

}
- (void)setGoodsModel:(Goods_order_setItem *)goodsModel {
    _goodsModel = goodsModel;
    self.titleLab.text = _goodsModel.goods_name;
}
-(void)setSkuModel:(Sku_order_setItem *)skuModel {
    _skuModel = skuModel;
    NSLog(@"%@,%@",_skuModel.image,[[CCTools sharedInstance] IsChinese:_skuModel.image]);
//    [self.imag sd_setImageWithURL:[NSURL URLWithString:[[CCTools sharedInstance] IsChinese:_skuModel.image]] placeholderImage:IMAGE_NAME(@"")];
    [self.imag setImageWithURL:[NSURL URLWithString:_skuModel.image] placeholder:IMAGE_NAME(@"")];
    self.priceLab.text =[NSString stringWithFormat:@"￥%@",STRING_FROM_0_FLOAT(skuModel.play_price)];
    self.numberLab.text = [NSString stringWithFormat:@"x%ld",skuModel.amount];
    self.subTitle.text = skuModel.specoption;
    if (_skuModel.can_back) {
        self.outBtn.hidden = NO;
        
    } else {
        self.outBtn.hidden = YES;
    }
    
}
@end
