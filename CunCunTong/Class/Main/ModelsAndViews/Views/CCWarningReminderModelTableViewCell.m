//
//  CCWarningReminderModelTableViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/1.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCWarningReminderModelTableViewCell.h"
#import "CCWarningReminderModel.h"
@implementation CCWarningReminderModelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lineView.backgroundColor = UIColorHex(0xf7f7f7);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BaseModel *)model {
    CCWarningReminderModel *mmm = (CCWarningReminderModel *)model;
    self.dateLab.text = mmm.create_time;
    self.content.text = mmm.goods_name;
    [self.imageViewsss sd_setImageWithURL:[NSURL URLWithString:mmm.image]];
    if (mmm.types == 0) {
        self.title.text = @"您的商品超储啦，请及时处理!";
    } else if(mmm.types == 1){
        self.title.text =[NSString stringWithFormat:@"您的商品仅剩%ld件啦，请及时补充库存!",mmm.count];
    } else {
        self.title.text = [NSString stringWithFormat:@"您的商品还有%ld天就到期啦，请及时处理!",mmm.days];
    }
    if (mmm.readed) {
        self.noRead.hidden = YES;
    } else {
       self.noRead.hidden = NO;
    }
    
}
+ (CGFloat)height {
    return 115;
}
@end
