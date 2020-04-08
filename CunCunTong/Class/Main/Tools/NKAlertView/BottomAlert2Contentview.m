//
//  BottomAlert2Contentview.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/31.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "BottomAlert2Contentview.h"

//@implementation BottomAlert2Contentview

#import "NKAlertView.h"
#import "CCTextCustomTableViewCell.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlert2Contentview ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BottomAlert2Contentview

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        [self setUI];
        
        self.tableView.frame = CGRectMake(0, 128, CGRectGetWidth(frame), CGRectGetHeight(frame) - 128-66);
        [self.tableView registerNib:CCTextCustomTableViewCell.loadNib forCellReuseIdentifier:@"cell1234"];
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = krgb(255,157,52);
        rightBtn.tag = 12;
        [rightBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.layer.masksToBounds = YES;
        rightBtn.layer.cornerRadius = 23;
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 56, CGRectGetWidth(frame)-20, 46);
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 70)];
        self.tableView.tableFooterView = footerView;
        UILabel *pricelab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_333333;
            view.font = FONT_13;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view.text = @"购买数量";
            view ;
        });
        [footerView addSubview:pricelab];
        [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(footerView).mas_offset(20);
            make.left.mas_equalTo(footerView).mas_offset(10);
            make.width.mas_equalTo(Window_W/2);
            make.height.mas_equalTo(17);
        }];
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(Window_W - 110, 20, 100, 30)];
        numberButton.shakeAnimation = YES;
        numberButton.increaseImage = [UIImage imageNamed:@"加号 1"];
        numberButton.decreaseImage = [UIImage imageNamed:@"减号"];
        
        numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus){
            NSLog(@"%f",number);
        };
        
        [footerView addSubview:numberButton];
    }
    return self;
}
- (void)setUI {
   UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 128)];
//        self.tableView.tableHeaderView = headView;
    [self addSubview:headView];
    
    UIImageView *goodsImageView = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view;
    });
    [headView addSubview:goodsImageView];
    [goodsImageView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView).mas_offset(10);
        make.top.mas_equalTo(headView).mas_offset(10);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(107);
    }];
    [goodsImageView setLayerShadow:kWhiteColor offset:CGSizeMake(0, 0) radius:5];
    UILabel *pricelab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [headView addSubview:pricelab];
    [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(28);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
      UIImageView *icon = ({
          UIImageView *view = [UIImageView new];
          view.contentMode = UIViewContentModeScaleAspectFill ;
          view.layer.masksToBounds = YES ;
          view.userInteractionEnabled = YES;
          view.image = IMAGE_NAME(@"叉号图标");
          view;
      });
      [headView addSubview:icon];
      [icon mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(headView).mas_offset(10);
          make.right.mas_equalTo(headView).mas_offset(-10);
          make.width.mas_equalTo(21);
          make.height.mas_equalTo(21);
      }];
      [icon addTapGestureWithBlock:^(UIView *gestureView) {
          NKAlertView *alertView = (NKAlertView *)self.superview;
          [alertView hide];
      }];
    UILabel *kucunLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [headView addSubview:kucunLab];
    [kucunLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pricelab.mas_bottom).mas_offset(16);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W*0.3);
        make.height.mas_equalTo(17);
    }];
    UILabel *selectLab = ({
        UILabel *view = [UILabel new];
        view.textColor = color_textBg_C7C7D1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [self addSubview:selectLab];
    [selectLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kucunLab.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(goodsImageView.mas_right).mas_offset(10);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTextCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1234"];
    cell.titleLab.text = @"UITableViewCell";
    cell.subTitleLab.text = @"UITableViewCell";
    return cell;
}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

@end


