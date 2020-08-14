
//
//  CCHeadInfoTableViewCell.m
//  CunCunHuiSupplier
//
//  Created by GOOUC on 2020/5/12.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCHeadInfoTableViewCell.h"

@implementation CCHeadInfoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =COLOR_333333;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view;
    });
    [self.contentView addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(177, 14));
        make.centerY.mas_equalTo(self.contentView).mas_offset(0);
    }];
    UILabel *mobleNumberLab = ({
        UILabel *view = [UILabel new];
        view.textColor = krgb(254,102,50);
        view.font = STFont(13);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentRight;
        view ;
    });

    [self.contentView addSubview:mobleNumberLab];
    [mobleNumberLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-10);
        make.size.mas_equalTo(CGSizeMake(117, 14));
        make.centerY.mas_equalTo(nameLab).mas_offset(0);
    }];
    self.titleLab = nameLab;
    self.stateLab = mobleNumberLab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setBackModel:(CCBackOrderListModel *)backModel {
    _backModel = backModel;
    _titleLab.text = [NSString stringWithFormat:@"订单号：%@",_backModel.order_num];
    switch (_backModel.status) {//    状态,0：待审核，1：拒绝，2-3：待出发，4：在路上，5：待提货，6:商品有误，关闭，-1和7：待退款，8：待确认收款，9：已完成
        case 0:
            _stateLab.text = @"待审核";
            break;
        case 1:
            _stateLab.text = @"拒绝";
            break;
        case 2:
            _stateLab.text = @"待出发";
            break;
        case 3:
            _stateLab.text = @"待出发";
            break;
        case 4:
            _stateLab.text = @"在路上";
            break;
        case 5:
            _stateLab.text = @"待提货";
            break;
        case 6:
            _stateLab.text = @"商品有误，关闭";
            break;
        case 7:
            _stateLab.text = @"待退款";
            break;
        case -1:
            _stateLab.text = @"待退款";
            break;
        case 8:
            _stateLab.text = @"待确认收款";
            break;
        case 9:
            _stateLab.text = @"已完成";
            break;
        default:
            break;
    }
}
- (void)setModel:(CCMyOrderModel *)model {
    _model = model;
    _titleLab.text = [NSString stringWithFormat:@"订单号：%@",model.order_num];
     switch (model.status) {
         case 0:
             _stateLab.text = @"待支付";
             break;
         case 1:
             _stateLab.text = @"待发货";
             break;
         case 2:
             _stateLab.text = @"运输中";
             break;
         case 3:
             _stateLab.text = @"已完成";
             break;
         case 4:
             _stateLab.text = @"关闭";
             break;
         case 5:
             _stateLab.text = @"已送达";
             break;

         default:
             break;
     }
}
//-(void)setFrame:(CGRect)frame{
//    CGFloat margin = 10;
//    frame.origin.x = margin;
//    frame.size.width = SCREEN_WIDTH - margin*2;
//    [super setFrame:frame];
//}
@end
