//
//  CCCententAlertErWeiMaView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/4/3.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCententAlertErWeiMaView.h"

@implementation CCCententAlertErWeiMaView





- (void)setupUI {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = kWhiteColor;
    UILabel *taRendaiFutitlelab = ({
        UILabel *view = [UILabel new];
        view.textColor =kMainColor;
        view.font = STFont(14);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"扫一扫二维码，替我付款~";
        view ;
    });
    [self addSubview:taRendaiFutitlelab];
    [taRendaiFutitlelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(44);
        make.size.mas_equalTo(CGSizeMake(217, 14));
        make.centerX.mas_equalTo(self).mas_offset(0);
    }];
    
    UIImageView *iconIamgeView4 = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.image = [UIImage imageNamed:@""];
        view.layer.masksToBounds = YES ;
        view ;
    });
    [self addSubview:iconIamgeView4];
    [iconIamgeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(taRendaiFutitlelab).mas_offset(44);
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.height.width.mas_equalTo(150);
    }];
    
    
}





@end
