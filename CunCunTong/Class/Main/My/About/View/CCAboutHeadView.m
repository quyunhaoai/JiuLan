

//
//  CCAboutHeadView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/7/11.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCAboutHeadView.h"

@implementation CCAboutHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {

     UIImageView *areaIcon = ({
         UIImageView *view = [UIImageView new];
         view.contentMode = UIViewContentModeScaleAspectFill ;
         view.layer.masksToBounds = YES ;
         view.userInteractionEnabled = YES ;
         view.layer.cornerRadius = 10;
         [view setImage:IMAGE_NAME(@"村村仓logo无底色_站长 180")];
         view;
     });
//    [[CCTools sharedInstance] addShadowToView:areaIcon withColor:KKColor(0, 0, 0, 0.2)];
//    UIView *view2 = [[UIView alloc] init];
//    view2.backgroundColor = [UIColor clearColor];
//    view2.frame = CGRectMake((Window_W-60)/2, 50, 60, 60);
//
//    view2.layer.shadowOpacity = 0.4;
//    view2.layer.shadowOffset = CGSizeMake(0, 2);
//    view2.layer.shadowRadius = 5;
//
//    
//    UIView *view1 = [[UIView alloc] init];
//    view1.frame = CGRectMake(0, 0, 60, 60);
//    view1.layer.masksToBounds = YES;
//    view1.layer.cornerRadius = 10;
//    view1.backgroundColor = [UIColor whiteColor];
//    view1.layer.contents = (id)[UIImage imageNamed:@"村村仓logo无底色_站长 180"].CGImage;;
//
//
//    [self addSubview:view2];
//    [view2 addSubview:view1];
     [self addSubview:areaIcon];
     [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self).mas_offset(50);
         make.size.mas_equalTo(CGSizeMake(60, 60));
         make.centerX.mas_equalTo(self.mas_centerX);
     }];
     UILabel *nameLab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(17);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentCenter;
         view.text = @"村村仓";
         view ;

     });
     [self addSubview:nameLab];
     [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self).mas_offset(0);
         make.size.mas_equalTo(CGSizeMake(277, 14));
         make.top.mas_equalTo(areaIcon.mas_bottom).mas_offset(10);
     }];

     UILabel *addressLab = ({
         UILabel *view = [UILabel new];
         view.textColor =COLOR_333333;
         view.font = STFont(13);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentCenter;
         view.numberOfLines = 1;
         view.text = [NSString stringWithFormat:@"Version %@", [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
         view ;
     });
     [self addSubview:addressLab];
     [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self).mas_offset(0);
         make.size.mas_equalTo(CGSizeMake(247, 14));
         make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(10);
     }];
}
@end
