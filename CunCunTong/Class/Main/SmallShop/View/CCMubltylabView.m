//
//  CCMubltylabView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/10.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCMubltylabView.h"

@implementation CCMubltylabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    for (int a = 0; a<4; a++) {
        UILabel *addressLab = ({
            UILabel *view = [UILabel new];
            view.textColor =COLOR_333333;
            view.font = STFont(13);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentCenter;
            view.numberOfLines = 1;
            view.text = @"进货数量";
            view ;
        });
        [self addSubview:addressLab];
        [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self).mas_offset(0);
            make.size.mas_equalTo(CGSizeMake(117, 14));
            make.top.mas_equalTo(a*20+10);
        }];
        if (a == 0) {
            addressLab.textColor = krgb(36,149,143);
            addressLab.font = FONT_15;
            addressLab.text = @"1000";
        } else if (a == 2) {
            addressLab.textColor = krgb(255,0,0);
            addressLab.font = FONT_15;
            addressLab.text = @"3000";
        } else if (a == 3){
            addressLab.text = @"库存金额";
        }
    }
    
}
@end
